/**
  * WinCC OA Open Library
  * @author DMC, Inc. http://www.dmcinfo.com
  *
  * File: ExitPanel.ctl
  *
  * Revisions: 2019-01-07 - Eric Baggen (eric.baggen@dmcinfo.com) : Created
  *
  * @description
  * This behavior opens the generic WinCC OA Help popup.
*/

#uses "OpenLibrary/Classes/Interfaces/Behaviors/IActionBehavior"

class OpenHelpActionBehaviorClass : IActionBehaviorClass
{
  public OpenHelpActionBehaviorClass() { }

  public bool invoke()
  {
    pt_init_PT_navi_hlp();
    std_help("PVSS");
    return true;
  }
};
