/**
  * WinCC OA Open Library
  * @author DMC, Inc. http://www.dmcinfo.com
  *
  * File: Component.ctl
  *
  * Revisions: 2019-01-07 - Eric Baggen (eric.baggen@dmcinfo.com) : Created
  *
  * @description
  * This component allows developers to better interface with the Siemens Open Library components
  * It contains a collection of action and display behaviors, which are passed to it during construction through dependency injection
  * Because we are referencing the behaviors with smart pointers that use automatic garbage collection, we must keep a collection of these pointers so that they are not automatically destroyed
*/

#uses "OpenLibrary/Classes/Interfaces/Behaviors/IDisplayBehavior"
#uses "OpenLibrary/Classes/Interfaces/Behaviors/IActionBehavior"
#uses "OpenLibrary/Classes/Collections/List"
#uses "OpenLibrary/Constants/Colors"

class ComponentClass
{
  private dyn_shape displayShapes;
  private ListClass actionBehaviors, displayBehaviors;
  private bool hasErrors = false;

  public ComponentClass(dyn_shape displayShapes)
  {
    this.displayShapes = displayShapes;
  }

  public void addActionBehavior(shared_ptr<IActionBehaviorClass> actionBehavior)
  {
    if (!this.hasErrors)
    {
      this.actionBehaviors.add(actionBehavior);
    }
  }

  public void addDisplayBehavior(shared_ptr<IDisplayBehaviorClass> displayBehavior)
  {
    if (!this.hasErrors)
    {
      displayBehavior.apply(displayShapes) ?
        this.displayBehaviors.add(displayBehavior) : this.handleError();
    }
  }

  public void invokeAction()
  {
    ListIteratorClass Iterator = this.actionBehaviors.createIterator();
    while (Iterator.hasNext())
    {
      if (this.hasErrors)
      {
        break;
      }

      shared_ptr<IActionBehaviorClass> actionBehavior = Iterator.next();

      if (!actionBehavior.invoke())
      {
        this.handleError();
      }
    }
  }

  // In case of a DPE DNE error, this class is responsible for removing all of its behaviors to
  // ensure that the corresponding UI shape is remains as _dpedoesnotexist purple color, per OA defaults.
  // The behavior that caught the non-existant DPE is responsible for logging the error for debugging and passing it to this component.
  private void handleError()
  {
    this.hasErrors = true;
    this.actionBehaviors.clear();
    this.displayBehaviors.clear();
    for (int i = 1; i <= dynlen(displayShapes); i++)
    {
      shape displayShape = displayShapes[i];
      displayShape.color = DP_DNE_COLOR;
    }
  }
};
