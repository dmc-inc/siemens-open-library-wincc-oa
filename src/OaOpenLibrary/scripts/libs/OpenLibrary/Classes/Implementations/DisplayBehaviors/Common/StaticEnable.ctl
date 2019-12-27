/**
  * WinCC OA Open Library
  * @author DMC, Inc. http://www.dmcinfo.com
  *
  * File: StaticEnable.ctl
  *
  * Revisions: 2019-01-10 - Nick Leisle (nicholas.leisle@dmcinfo.com) : Created
  *
  * @description
  * This behavior statically sets a shape's editable property
*/

#uses "OpenLibrary/Classes/Interfaces/Behaviors/IDisplayBehavior"

class StaticEnableDisplayBehaviorClass : IDisplayBehaviorClass
{
  private bool isEnabled;

  public StaticEnableDisplayBehaviorClass(bool isEnabled)
  {
    this.isEnabled = isEnabled;
  }

  public bool apply(dyn_shape displayShapes)
  {
    for (int i = 1; i <= dynlen(displayShapes); i++)
    {
      shape displayShape = displayShapes[i];

      // Text fields operate differently than other shapes. Their enabled property is "editible". All others should use enabled.
      if (displayShape.shapeType == "TEXT_FIELD")
      {
        displayShape.editable = this.isEnabled;
      }
      else
      {
        displayShape.enabled = this.isEnabled;
      }
    }

    return true;
  }
};
