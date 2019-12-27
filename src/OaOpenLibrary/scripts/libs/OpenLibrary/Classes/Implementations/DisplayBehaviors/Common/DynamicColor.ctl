/**
  * WinCC OA Open Library
  * @author DMC, Inc. http://www.dmcinfo.com
  *
  * File: DpColor.ctl
  *
  * Revisions: 2019-01-07 - Eric Baggen (eric.baggen@dmcinfo.com) : Created
  *            2019-01-10 - Nick Leisle (nicholas.leisle@dmcinfo.com: Modified to handle integers in addition to bools
  *
  * @description
  * This behavior subscribes a shape's background color to integer datapoint's value change event
  * The active and inactive colors, as well as the trigger value are passed through the constructor
*/
#uses "OpenLibrary/Classes/Interfaces/Behaviors/IDisplayBehavior"
#uses "OpenLibrary/Enums/ColoringType"
#uses "OpenLibrary/ErrorHandling"

class DynamicColorDisplayBehaviorClass : IDisplayBehaviorClass
{
  private dyn_shape displayShapes;
  private string dpe, activeColor, inactiveColor;
  private ColoringType colorType;
  private int triggerValue;
  public DynamicColorDisplayBehaviorClass(string dpe, string activeColor, string inactiveColor, ColoringType colorType = ColoringType::Back, int triggerValue = 1)
  {
    this.dpe = dpe;
    this.activeColor = activeColor;
    this.inactiveColor = inactiveColor;
    this.colorType = colorType;
    this.triggerValue = triggerValue;
  }


  public bool apply(dyn_shape displayShapes)
  {
    this.displayShapes = displayShapes;

    if (!verifyDpExists(this.dpe))
    {
      return false;
    }

    dpConnect("onValueChanged", this.dpe);
    return true;
  }


  private void onValueChanged(string dpe, int value)
  {
    string newColor = (value == this.triggerValue) ? this.activeColor : this.inactiveColor;

    for (int i = 1; i <= dynlen(this.displayShapes); i++)
    {
      shape displayShape = displayShapes[i];
      switch (this.colorType)
      {
        case ColoringType::Fore:
          displayShape.foreCol = newColor;
          break;
        case ColoringType::Back:
          displayShape.backCol = newColor;
          break;
        case ColoringType::Full:
          displayShape.color = newColor;
          break;
      }
    }
  }
};
