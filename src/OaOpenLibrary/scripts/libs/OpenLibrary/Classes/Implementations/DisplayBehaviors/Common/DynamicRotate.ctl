/**
  * WinCC OA Open Library
  * @author DMC, Inc. http://www.dmcinfo.com
  *
  * File: DynamicRotate.ctl
  *
  * Revisions: 2019-03-05 - Nick Leisle (nicholas.leisle@dmcinfo.com: Created
  *
  * @description
  * This behavior dynamically adjusts a shape's "rotation" based on a given DPE
  *
*/


#uses "OpenLibrary/Classes/Interfaces/Behaviors/IDisplayBehavior"
#uses "OpenLibrary/ErrorHandling"
#uses "OpenLibrary/Enums/RotationDirectionType"

class DynamicRotateDisplayBehaviorClass : IDisplayBehaviorClass
{
  private dyn_shape displayShapes;
  private string dpe;
  private RotationDirectionType rotationDirection;
  private float startAngle;
  private float maxRotation;
  private float dpeMax = 360;
  private float dpeMin = 0;

  public DynamicRotateDisplayBehaviorClass(string dpe, RotationDirectionType rotationDirection = RotationDirectionType::CW, float startAngle = 0, float maxRotation = 360)
  {
    this.dpe = dpe;
    this.rotationDirection = rotationDirection;
    this.startAngle = startAngle;
    this.maxRotation = maxRotation;
  }

  public bool apply(dyn_shape displayShapes)
  {
    this.displayShapes = displayShapes;

    if (!verifyDpExists(this.dpe))
    {
      return false;
    }
    //Acquire min/max dpe values
    dpGet(this.dpe + ":_pv_range.._min", this.dpeMin);
    dpGet(this.dpe + ":_pv_range.._max", this.dpeMax);
    dpConnect("onValueChanged", this.dpe);
    return true;
  }

  //Changes orientation of panel objects (vertical vs. horizontal)
  void onValueChanged(string dpe, float value)
  {
    float absoluteAngle;
    switch(this.rotationDirection)
    {
      case RotationDirectionType::CW:
        absoluteAngle = -(startAngle + ((value-this.dpeMin)/(this.dpeMax-this.dpeMin)*this.maxRotation));
        break;
      case RotationDirectionType::CCW:
        absoluteAngle = (startAngle + ((value-this.dpeMin)/(this.dpeMax-this.dpeMin)*this.maxRotation));
        break;
    }

    for (int i = 1; i <= dynlen(this.displayShapes); i++)
    {
      shape displayShape = this.displayShapes[i];
      setValue(displayShape, "rotation", absoluteAngle);
    }
  }
};
