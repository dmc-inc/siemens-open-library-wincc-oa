/**
  * WinCC OA Open Library
  * @author DMC, Inc. http://www.dmcinfo.com
  *
  * File: DpEnableWithColor.ctl
  *
  * Revisions: 2019-01-07 - Eric Baggen (eric.baggen@dmcinfo.com) : Created
  *            2019-01-10 - Nick Leisle (nicholas.leisle@dmcinfo.com): adapted to handle integers in addition to bool values
  *
  * @description
  * This behavior subscribes a shape's enabled state and background color to the change events of boolean and string datapoints
  * Becuase this behavior is co dependent on multiple tags, it must use both values when determining state
*/
#uses "OpenLibrary/Classes/Interfaces/Behaviors/IDisplayBehavior"
#uses "OpenLibrary/ErrorHandling"

class DynamicEnableWithColorDispayBehaviorClass : IDisplayBehaviorClass
{
  private string enableDpe, colorDpe, activeColor, inactiveColor;
  private dyn_shape displayShapes;
  private int colorTriggerValue;
  public DynamicEnableWithColorDispayBehaviorClass(string enableDpe, string colorDpe, string activeColor, string inactiveColor, int colorTriggerValue = 1)
  {
    this.activeColor = activeColor;
    this.inactiveColor = inactiveColor;
    this.colorTriggerValue = colorTriggerValue;
    this.enableDpe = enableDpe;
    this.colorDpe = colorDpe;
  }
  public bool apply(dyn_shape displayShapes)
  {
    this.displayShapes = displayShapes;

    if (!verifyDpExists(this.enableDpe) || !verifyDpExists(this.colorDpe))
    {
      return false;
    }

    dpConnect("onPropertyChanged", makeDynString(this.enableDpe, this.colorDpe));
    return true;
  }

  private void onPropertyChanged(dyn_string dpes, dyn_anytype values)
  {
    int colorValue = values[2];
    string backColorString = (colorValue == this.colorTriggerValue) ? this.activeColor : this.inactiveColor;
    string foreColorString = generateContrastingColors(makeDynString(backColorString))[1];

    bool isEnabled = values[1];


    // Set color
    // The disabled color will be the current color - 30% with 50% transparency
    if (!isEnabled)
    {
      int red, green, blue, alpha;
      colorToRgb(backColorString, red, green, blue, alpha);
      backColorString = "{" + (int)(red * .7) + "," + (int)(green * .7) + "," + (int)(blue * .7) + ",50}";
    }

    for (int i = 1; i <= dynlen(displayShapes); i++)
    {
      shape displayShape = displayShapes[i];
      // Set colors and enabled status for each shape
      displayShape.enabled = isEnabled;
      displayShape.backCol = backColorString;
      displayShape.foreCol = foreColorString;
    }
  }
};
