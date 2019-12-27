/**
  * WinCC OA Open Library
  * @author DMC, Inc. http://www.dmcinfo.com
  *
  * File: OpenPopup.ctl
  *
  * Revisions: 2019-01-22 - Nick Leisle (nicholas.leisle@dmcinfo.com):
  *                         Created
  *            2019-04-02 - Nick Leisle (nicholas.leisle@dmcinfo.com):
  *                         Modified error handling to look for file paths in subproject in addition to base project
  *
  * @description
  * This behavior allows for the opening of a generic popup.
*/

#uses "OpenLibrary/Classes/Interfaces/Behaviors/IActionBehavior"
#uses "OpenLibrary/ErrorHandling"
#uses "OpenLibrary/Enums/FileType"

class OpenPopupActionBehaviorClass : IActionBehaviorClass
{
  private string popupPath;
  private dyn_string dpList;

  public OpenPopupActionBehaviorClass(dyn_string dpList, string popupPath)
  {
    this.popupPath = popupPath;
    this.dpList = dpList;
  }

  public bool invoke()
  {
    if (verifyFileExists(this.popupPath, FileType::Panel) == false)
    {
      return false;
    }

    //Open popup
    ChildPanelOnRelativModal(
        this.popupPath,
        "",
        dpList,
        0,
        0
      );
    return true;
  }
};
