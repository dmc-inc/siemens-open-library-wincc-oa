/**
  * WinCC OA Open Library
  * @author DMC, Inc. http://www.dmcinfo.com
  *
  * File: CopyText.ctl
  *
  * Revisions: 2019-01-10 - Nick Leisle (nicholas.leisle@dmcinfo.com) : Created
  *
  * @description
  * When invoked, this behavior copies the text of a text box to a specific DP.
*/

#uses "OpenLibrary/Classes/Interfaces/Behaviors/IActionBehavior"
#uses "OpenLibrary/ErrorHandling"

class CopyTextActionBehaviorClass : IActionBehaviorClass
{
  private string dpe;
  private shape textBox;

  public CopyTextActionBehaviorClass(string dpe, shape textBox)
  {
    this.dpe = dpe;
    this.textBox = textBox;
  }

  public bool invoke()
  {
    //Error handling
    if (!verifyDpExists(this.dpe))
    {
      return false;
    }

    dpSetWait(this.dpe, textBox.text);

    //provide feedback on successful write by highlighting all text (future addition)

    return true;
  }
};
