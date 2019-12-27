/**
  * WinCC OA Open Library
  * @author DMC, Inc. http://www.dmcinfo.com
  *
  * File: DynamicEnable.ctl
  *
  * Revisions: 2019-01-07 - Eric Baggen (eric.baggen@dmcinfo.com) : Created
  *
  * @description
  * This behavior subscribes a shape's enabled state to boolean datapoint's value change event
*/

#uses "OpenLibrary/Classes/Interfaces/Behaviors/IDisplayBehavior"
#uses "OpenLibrary/Macros"
#uses "OpenLibrary/ErrorHandling"

class DynamicEnableDisplayBehaviorClass : IDisplayBehaviorClass
{
  private dyn_shape displayShapes;
  private string dpe;
  private int enableTriggerValue;

  public DynamicEnableDisplayBehaviorClass(string dpe, int enableTriggerValue = 1)
  {
    this.dpe = dpe;
    this.enableTriggerValue = enableTriggerValue;
  }

  public bool apply(dyn_shape displayShapes)
  {
    this.displayShapes = displayShapes;

    if (!verifyDpExists(this.dpe))
    {
      return false;
    }

    dpConnect("onEnabledChanged", this.dpe);
    return true;
  }


  private void onEnabledChanged(string dpe, int value)
  {
    bool isEnabled = value == this.enableTriggerValue;

    for (int i = 1; i <= dynlen(this.displayShapes); i++)
    {
      shape displayShape = this.displayShapes[i];
      if (displayShape.shapeType == "TEXT_FIELD")
      {
        displayShape.editable = isEnabled;
      }
      else
      {
        displayShape.enabled = isEnabled;
      }
    }
  }
};
