/**
  * WinCC OA Open Library
  * @author DMC, Inc. http://www.dmcinfo.com
  *
  * File: DpEnableWithEnumColor.ctl
  *
  * Revisions: 2019-03-13 - Nick Leisle (nicholas.leisle@dmcinfo.com): created
  *
  * @description
  * This behavior subscribes a shape's enabled state and background color to the change events of boolean and string datapoints
  * Becuase this behavior is co dependent on multiple tags, it must use both values when determining state
*/
#uses "OpenLibrary/Classes/Interfaces/Behaviors/IDisplayBehavior"
#uses "OpenLibrary/ErrorHandling"

class DynamicEnableWithEnumColorDispayBehaviorClass : IDisplayBehaviorClass
{
  private string enableDpe, colorDpe;
  private dyn_string colorList;
  private int offset;
  private dyn_shape displayShapes;
  public DynamicEnableWithEnumColorDispayBehaviorClass(string enableDpe, string colorDpe, dyn_string colorList, int offset = 0)
  {
    this.enableDpe = enableDpe;
    this.colorDpe = colorDpe;
    this.colorList = colorList;
    this.offset = offset;
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
    bool isEnabled = values[1];
    int colorValue = values[2];




    // Set color
    // The disabled color will be the current color - 30% with 50% transparency

    string backColorString = this.colorList[colorValue + this.offset + 1];
    string foreColorString = generateContrastingColors(this.colorList)[colorValue + this.offset + 1];


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
