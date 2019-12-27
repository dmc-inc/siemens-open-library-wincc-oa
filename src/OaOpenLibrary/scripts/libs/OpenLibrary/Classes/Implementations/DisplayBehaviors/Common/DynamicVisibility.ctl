/**
  * WinCC OA Open Library
  * @author DMC, Inc. http://www.dmcinfo.com
  *
  * File: DynamicVisibility.ctl
  *
  * Revisions: 2019-01-22 - Nick Leisle (nicholas.leisle@dmcinfo.com) :
  *                         Created
  *
  * @description
  * This behavior subscribes a shape's visibility to datapoint's value change event
*/

#uses "OpenLibrary/Classes/Interfaces/Behaviors/IDisplayBehavior"
#uses "OpenLibrary/Enums/VisibilityType"
#uses "OpenLibrary/Macros"
#uses "OpenLibrary/ErrorHandling"

class DynamicVisibilityDisplayBehaviorClass : IDisplayBehaviorClass
{
  private dyn_shape displayShapes;
  private string dpe;
  private int triggerValue;
  private VisibilityType visibility; //Trigger makes the object visible or invisible

  public DynamicVisibilityDisplayBehaviorClass(string dpe, int triggerValue = 1, VisibilityType visibility = VisibilityType::Visible)
  {
    this.dpe = dpe;
    this.triggerValue = triggerValue;
    this.visibility = visibility;
  }

  public bool apply(dyn_shape displayShapes)
  {
    this.displayShapes = displayShapes;

    if (!verifyDpExists(this.dpe))
    {
      return false;
    }

    dpConnect("onVisibilityChanged", this.dpe);
    return true;
  }


  private void onVisibilityChanged(string dpe, int value)
  {
    for (int i = 1; i <= dynlen(displayShapes); i++)
    {
      shape displayShape = displayShapes[i];

      // If if the dpe equals the trigger value, change shape visibility to desired visibility type
      switch (this.visibility)
      {
        case VisibilityType::Visible:
          displayShape.visible = (value == this.triggerValue) ? TRUE : FALSE;
          break;
        case VisibilityType::Invisible:
          displayShape.visible = (value == this.triggerValue) ? FALSE : TRUE;
          break;
      }
    }
  }
};
