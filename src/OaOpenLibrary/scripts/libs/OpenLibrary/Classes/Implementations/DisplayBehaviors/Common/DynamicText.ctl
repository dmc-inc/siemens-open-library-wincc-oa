/**
  * WinCC OA Open Library
  * @author DMC, Inc. http://www.dmcinfo.com
  *
  * File: DpText.ctl
  *
  * Revisions: 2019-01-07 - Eric Baggen (eric.baggen@dmcinfo.com) : Created
  *            2019-01-11 - Nick Leisle (nicholas.leisle@dmcinfo.com): added dpValToString to reflect units
  *
  * @description
  * This behavior subscribes a shape's text to string datapoint's value change event
*/

#uses "OpenLibrary/Classes/Interfaces/Behaviors/IDisplayBehavior"
#uses "OpenLibrary/Macros"
#uses "OpenLibrary/ErrorHandling"

class DynamicTextDisplayBehaviorClass : IDisplayBehaviorClass
{
  private dyn_shape displayShapes;
  private string dpe;

  public DynamicTextDisplayBehaviorClass(string dpe)
  {
    this.dpe = dpe;
  }

  public bool apply(dyn_shape displayShapes)
  {
    this.displayShapes = displayShapes;

    if (!verifyDpExists(this.dpe))
    {
      return false;
    }

    dpConnect("onTextChanged", this.dpe);
    return true;
  }

  private void onTextChanged(string dpe, string text)
  {
    for (int i = 1; i <= dynlen(displayShapes); i++)
    {
      shape displayShape = displayShapes[i];
      displayShape.text = dpValToString(dpe, text, true);
    }
  }
};
