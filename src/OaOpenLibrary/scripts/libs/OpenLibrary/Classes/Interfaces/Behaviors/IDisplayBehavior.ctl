/**
  * WinCC OA Open Library
  * @author DMC, Inc. http://www.dmcinfo.com
  *
  * File: IDisplayBehavior.ctl
  *
  * Revisions: 2019-01-07 - Eric Baggen (eric.baggen@dmcinfo.com) : Created
  *
  * @description
  * A display behavior is any predefined action that a developer wants to implement on a UI shape object
  * This may include subscribing a shape's property a datapoint's value change event or statically setting properties at construction time
  * All concretions of this interface must define the display behavior with the `apply` method.
  * The displayShape parameter should be the shape upon which the developer would like to apply the display behavior
  * Additional parameters required by the behavior (datapoints for subscriptions, color enumerations, text strings, etc.) should be passed as constructor parameters
*/

class IDisplayBehaviorClass
{
  public bool apply(dyn_shape displayShapes) { }
};
