/**
  * WinCC OA Open Library
  * @author DMC, Inc. http://www.dmcinfo.com
  *
  * File: DynamicSize.ctl
  *
  * Revisions: 2019-02-21 - Nick Leisle (nicholas.leisle@dmcinfo.com) : Created
  *
  * @description
  * This behavior dynamically adjusts a shape's "size" based on a given DPE
*/
#uses "OpenLibrary/Classes/Interfaces/Behaviors/IDisplayBehavior"
#uses "OpenLibrary/Enums/DirectionType"
class DynamicSizeDisplayBehaviorClass : IDisplayBehaviorClass
{
  //NOTE: MAKE SURE YOUR REFERENCE POINT IS AT THE NON-MOVING BASE OF YOUR OBJECT
  //      RESIZING A SHAPE REDUCES/INCREASES ITS SIZE PROPORTIONALLY ON EITHER SIDE OF THE REFERENCE
  //      I.E. IF YOUR REFERENCE IS IN THE MIDDLE, AN EQUAL AMOUNT WILL BE SHAVED OFF/ADDED TO EACH SIDE
  //           IF YOUR REFERENCE IS ON THE EDGE, THE SHAPE WILL GROW/SHRINK FROM THE OPPOSITE EDGE
  private dyn_shape displayShapes;
  private string dpe;
  private shape referenceShape;
  private DirectionType orientation;
  private float dpeMax = 100;
  private float dpeMin = 0;
  private int referenceSizeX;
  private int referenceSizeY;
  public DynamicSizeDisplayBehaviorClass(string dpe, shape referenceShape, DirectionType orientation)
  {
    this.dpe = dpe;
    this.referenceShape = referenceShape;
    this.orientation = orientation;
  }
  public bool apply(dyn_shape displayShapes)
  {
    this.displayShapes = displayShapes;
    //Acquire size of reference shape
    getValue(this.referenceShape, "size", this.referenceSizeX, this.referenceSizeY);
    if (!verifyDpExists(this.dpe))
    {
      return false;
    }
    //Acquire min/max dpe values
    dpGet(this.dpe + ":_pv_range.._min", this.dpeMin);
    dpGet(this.dpe + ":_pv_range.._max", this.dpeMax);
    //Call onSizeChanged when dpe value changes
    dpConnect("onSizeChanged", this.dpe);
    return true;
  }


  private void onSizeChanged(string dpe, int value)
  {
    int newX;
    int newY;
    switch(this.orientation)
    {
      case DirectionType::Horizontal:
        //calculate adjusted width & keep original height
        newX = (int)((value-dpeMin)/(dpeMax-dpeMin)*(float)this.referenceSizeX);
        newY = this.referenceSizeY;
        break;
      case DirectionType::Vertical:
        //calculate adjusted height & keep original width
        newX = this.referenceSizeX;
        newY = (int)((value-dpeMin)/(dpeMax-dpeMin)*(float)this.referenceSizeY);
        break;
    }
    //set display shapes' new sizes
    for (int i = 1; i <= dynlen(this.displayShapes); i++)
    {
      shape displayShape = this.displayShapes[i];
      setValue(displayShape, "size", newX, newY);
    }
  }
};
