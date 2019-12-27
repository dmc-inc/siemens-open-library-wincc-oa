/**
  * WinCC OA Open Library
  * @author DMC, Inc. http://www.dmcinfo.com
  *
  * File: Icon.ctl
  *
  * Revisions: 2019-01-07 - Eric Baggen (eric.baggen@dmcinfo.com) : Created
  *
  * @description
  * This behavior sets a shape's background to a specifed image in the icon folder of the project
  * If the specified file cannot be found, a default "missing file" icon is used
*/

#uses "OpenLibrary/Classes/Interfaces/Behaviors/IDisplayBehavior"
#uses "OpenLibrary/ErrorHandling"
#uses "OpenLibrary/Enums/FileType"

class IconDisplayBehaviorClass : IDisplayBehaviorClass
{
  private const string MISSING_IMAGE_PATH = "missingFile.png";
  private string picturePath;

  public IconDisplayBehaviorClass(string picturePath)
  {
    this.picturePath = (verifyFileExists(picturePath, FileType::Picture))
                       ? picturePath : this.MISSING_IMAGE_PATH;
  }

  public bool apply(dyn_shape displayShapes)
  {
    for (int i = 1; i <= dynlen(displayShapes); i++)
    {
      shape displayShape = displayShapes[i];
      displayShape.fill("[pattern,[fit_keep_ratio,any," + this.picturePath + "]]");
    }
    return true;
  }
};
