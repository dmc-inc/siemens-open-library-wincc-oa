/**
  * WinCC OA Open Library
  * @author DMC, Inc. http://www.dmcinfo.com
  *
  * File: ExitPanel.ctl
  *
  * Revisions: 2019-01-07 - Eric Baggen (eric.baggen@dmcinfo.com) : Created
  *
  * @description
  * This behavior closes the panel that called it
*/

#uses "OpenLibrary/Classes/Interfaces/Behaviors/IActionBehavior"

class ExitPanelActionBehaviorClass : IActionBehaviorClass
{
  public ExitPanelActionBehaviorClass() { }

  public bool invoke()
  {
    PanelOff();
    return true;
  }
};
