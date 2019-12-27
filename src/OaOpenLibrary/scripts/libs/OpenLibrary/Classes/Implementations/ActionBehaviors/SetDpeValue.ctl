/**
  * WinCC OA Open Library
  * @author DMC, Inc. http://www.dmcinfo.com
  *
  * File: DpPushButton.ctl
  *
  * Revisions: 2019-01-07 - Eric Baggen (eric.baggen@dmcinfo.com) : Created
  *
  * @description
  * This behavior sets a boolean datapoint true
  * It is meant to be used as a request, which would acknowledged and reset by a peripheral device, such as a PLC
*/

#uses "OpenLibrary/Classes/Interfaces/Behaviors/IActionBehavior"
#uses "OpenLibrary/Macros"

class SetDpeValueActionBehaviorClass : IActionBehaviorClass
{
  private string dpe;
  private int value;

  public SetDpeValueActionBehaviorClass(string dpe, int value = 1)
  {
    this.dpe = dpe;
    this.value = value;
  }

  public bool invoke()
  {
    if (!verifyDpExists(this.dpe))
    {
      return false;
    }

    dpSetWait(this.dpe, value);
    return true;
  }
};
