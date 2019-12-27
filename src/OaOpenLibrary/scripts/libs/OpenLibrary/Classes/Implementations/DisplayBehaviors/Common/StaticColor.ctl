/**
  * WinCC OA Open Library
  * @author DMC, Inc. http://www.dmcinfo.com
  *
  * File: StaticColor.ctl
  *
  * Revisions: 2019-01-07 - Eric Baggen (eric.baggen@dmcinfo.com) : Created
  *
  * @description
  * This behavior statically sets a shape's color. By default, it changes the background color.
*/

#uses "OpenLibrary/Classes/Interfaces/Behaviors/IDisplayBehavior"
#uses "OpenLibrary/Enums/ColoringType"

class StaticColorDisplayBehaviorClass : IDisplayBehaviorClass
{
  private string color;
  private ColoringType colorType;

  public StaticColorDisplayBehaviorClass(string color, ColoringType colorType = ColoringType::Back)
  {
    this.color = color;
    this.colorType = colorType;
  }

  public bool apply(dyn_shape displayShapes)
  {
    for (int i = 1; i <= dynlen(displayShapes); i++)
    {
      shape displayShape = displayShapes[i];
      switch (this.colorType)
      {
        case ColoringType::Fore:
          displayShape.foreCol = this.color;
          break;
        case ColoringType::Back:
          displayShape.backCol = this.color;
          break;
        case ColoringType::Full:
          displayShape.color = this.color;
          break;
      }
    }

    return true;
  }
};
