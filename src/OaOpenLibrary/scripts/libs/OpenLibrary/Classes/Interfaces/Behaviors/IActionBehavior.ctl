/**
  * WinCC OA Open Library
  * @author DMC, Inc. http://www.dmcinfo.com
  *
  * File: IActionBehavior.ctl
  *
  * Revisions: 2019-01-07 - Eric Baggen (eric.baggen@dmcinfo.com) : Created
  *
  * @description
  * An action behavior is any reusable action
  * This may include setting the value of a datapoint element or triggering a UI action (like closing a panel)
  * All concretions of this interface must define the action behavior within the `invoke` method.
  * Additional parameters required by the behavior (datapoints, values, text strings, etc.) should be passed as constructor parameters
*/
class IActionBehaviorClass
{
  public bool invoke() { }
};
