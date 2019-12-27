/**
  * WinCC OA Open Library
  * @author DMC, Inc. http://www.dmcinfo.com
  *
  * File: StaticText.ctl
  *
  * Revisions: 2019-01-07 - Eric Baggen (eric.baggen@dmcinfo.com) : Created
  *
  * @description
  * This behavior statically sets a shape's text
*/

#uses "OpenLibrary/Classes/Interfaces/Behaviors/IDisplayBehavior"

class StaticTextDisplayBehaviorClass : IDisplayBehaviorClass
{
  private string text;

  public StaticTextDisplayBehaviorClass(string text)
  {
    this.text = text;
  }

  public bool apply(dyn_shape displayShapes)
  {
    for(int i = 1; i <= dynlen(displayShapes); i++)
    {
      shape displayShape = displayShapes[i];
      displayShape.text = this.text;
    }
    return true;
  }
};
