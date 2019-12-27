/**
  * WinCC OA Open Library
  * @author DMC, Inc. http://www.dmcinfo.com
  *
  * File: DpToggleButton.ctl
  *
  * Revisions: 2019-01-07 - Eric Baggen (eric.baggen@dmcinfo.com) : Created
  *
  * @description
  * This behavior toggles the value of a specified boolean datapoint
*/

#uses "OpenLibrary/Classes/Interfaces/Behaviors/IActionBehavior"
#uses "OpenLibrary/Macros"
#uses "OpenLibrary/ErrorHandling"

class ToggleBooleanDpeActionBehaviorClass : IActionBehaviorClass
{
  private string dpe;

  public ToggleBooleanDpeActionBehaviorClass(string dpe)
  {
    this.dpe = dpe;
  }

  public bool invoke()
  {
    if (!verifyDpExists(this.dpe))
    {
      return false;
    }

    bool isToggled;
    dpGet(this.dpe, isToggled);
    dpSetWait(this.dpe, !isToggled);
    return true;
  }
};
