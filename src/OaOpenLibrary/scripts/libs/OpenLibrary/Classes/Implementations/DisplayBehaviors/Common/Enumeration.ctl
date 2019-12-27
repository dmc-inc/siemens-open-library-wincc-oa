/**
  * WinCC OA Open Library
  * @author DMC, Inc. http://www.dmcinfo.com
  *
  * File: DpEnumeration.ctl
  *
  * Revisions: 2019-01-11 - Eric Baggen (eric.baggen@dmcinfo.com) : Created
  *
  * @description
  * This behavior subscribes an enumerated property to a shape based on a datapoint's value.
  * This is a generic behavior in which the shape responds to any type of enumerated properties (text, colors, etc.)
*/

#uses "OpenLibrary/Classes/Interfaces/Behaviors/IDisplayBehavior"
#uses "OpenLibrary/ErrorHandling"
#uses "OpenLibrary/Constants/Colors"

class EnumerationDisplayBehaviorClass : IDisplayBehaviorClass
{
  private dyn_shape displayShapes;
  private string dpe, property;
  private dyn_anytype enumeration;
  private int offset;

  /*
    @params:
    dpe: The DPE to which the behavior should subscribe
    enumeration: any array of consistent properties from which the shape will select {1, 2, 3... {"a", "b", "c"...
    property: the property of the shape that should be subscribed to the DPE
    offset: an optional offset of the enumeration in the case that the enumeration is not zero-based
  */
  public EnumerationDisplayBehaviorClass(string dpe, dyn_anytype enumeration, string property, int offset = 0)
  {
    this.dpe = dpe;
    this.enumeration = enumeration;
    this.property = property;
    this.offset = offset;
  }

  public bool apply(dyn_shape displayShapes)
  {
    this.displayShapes = displayShapes;

    if (!verifyDpExists(this.dpe))
    {
      return false;
    }

    dpConnect("onValueChanged", this.dpe);
    return true;
  }

  private void onValueChanged(string dpe, int value)
  {

    // Check bounds of enumeration
    if ((value < this.offset) || (value >= dynlen(this.enumeration) + this.offset))
    {
      //Throw error
      throwIndexOutOfBoundsError(this.enumeration, value, dpe);

      //Apply undefined color and (if applicable) Index DNE text to shape(s)
      for (int i = 1; i <= dynlen(this.displayShapes); i++)
      {
        shape displayShape = this.displayShapes[i];

        displayShape.backCol = UNDEFINED_VALUE_COLOR;

        if (this.property == "text")
        {
          setValue(displayShape, "text", "Index DNE");
        }
      }
      return;
    }

    //If no out-of-bounds error exists, apply enumeration to shape property
    for (int i = 1; i <= dynlen(this.displayShapes); i++)
    {
      shape displayShape = this.displayShapes[i];
      setValue(displayShape, this.property, this.enumeration[value - this.offset + 1]);
    }
  }
};
