/**
  * WinCC OA Open Library
  * @author DMC, Inc. http://www.dmcinfo.com
  *
  * File: ErrorHandling.ctl
  *
  * Revisions: 2019-02-01 - Eric Baggen (eric.baggen@dmcinfo.com) : Created
  *
  * @description
  * This file contains generic reusable error handling functions
*/
#uses "OpenLibrary/Enums/FileType"
enum ErrorType
{
  NO_ERROR          = 1,
  DP_DOES_NOT_EXIST = -1,
  UNHANDLED_ERROR   = -2
};

// Verifications

public bool verifyDpExists(string dp, bool supressError = false)
{
  if (!dpExists(dp))
  {
    if (!supressError)
    {
      throwDatapointDoesNotExistError(dp);
    }
    return false;
  }
  return true;
}

public bool verifyDatapointType(string dp, string expectedDpt, bool supressError = false)
{
  if (dpTypeName(dp) != expectedDpt)
  {
    if (!supressError)
    {
      throwIncorrectDatapointTypeError(dp, expectedDpt);
    }
    return false;
  }

  return true;
}

public bool verifyDataType(string dp, int expectedType, bool supressError = false)
{
  if (dpElementType(dp) != expectedType)
  {
    if (!supressError)
    {
      throwIncorrectDataTypeError(dp, expectedType);
    }
    return false;
  }

  return true;
}

public bool verifyFileExists(string filePath, FileType fileType = FileType::Panel, bool supressError = false)
{
  //Error handling: check if file exists in project directory, any subproject directory, or
  //Extract project and subproject paths and pvss path from config file
  string configPath = getPath(CONFIG_REL_PATH) + "config";
  dyn_string projectPaths;
  dyn_string pvssPaths;
  paCfgReadValueList(configPath, "general", "proj_path", projectPaths);
  paCfgReadValueList(configPath, "general", "pvss_path", pvssPaths);
  bool fileExists = FALSE;

  //Determine proper file type:
  string fileTypePath;
  switch(fileType)
  {
    case FileType::Panel:
      fileTypePath = "/panels/";
      break;
    case FileType::Picture:
      fileTypePath = "/pictures/";
      break;
  }


  //Check if popup path exists in a pvss path
  for (int i = 1; i <= dynlen(pvssPaths); i++)
  {
    if(isfile(pvssPaths[i] + fileTypePath + filePath))
    {
      fileExists = TRUE;
    }
  }

  //Check if popup path exists in a project and subproject
  for (int i = 1; i <= dynlen(projectPaths); i++)
  {
    if(isfile(projectPaths[i] + fileTypePath + filePath))
    {
      fileExists = TRUE;
    }
  }

  //If the popup path does not exist in project or subproject, throw error
  if (fileExists == FALSE)
  {
    throwFileDoesNotExistError(filePath, fileType);
    return false;
  }
  return true;
}





// Exceptions

public void throwDatapointDoesNotExistError(string dpe)
{
  throwError(
    makeError(
        "",
        PRIO_SEVERE,
        ERR_IMPL,
        2,
        "Open Library Error: the datapoint element " + dpe + " does not exist. Called by panel: " + myPanelName()
    )
  );
}

public void throwFileDoesNotExistError(string filepath, FileType fileType = FileType::Panel)
{
  string fileTypeName = "panel";
  switch (fileType)
  {
    case FileType::Panel:
      fileTypeName = "panel";
      break;
    case FileType::Picture:
      fileTypeName = "picture";
      break;
  }


  throwError(
    makeError(
        "",
        PRIO_SEVERE,
        ERR_IMPL,
        2,
        "Open Library Error: the " + fileTypeName + " file " + filepath + " does not exist. Called by panel: " + myPanelName()
    )
  );
}

public void throwIndexOutOfBoundsError(dyn_anytype array, int badIndex, string dpIndex = "")
{
  throwError(
    makeError(
        "",
        PRIO_SEVERE,
        ERR_IMPL,
        2,
        "Open Library Error: Index " + badIndex + " is not defined" + ((dpIndex == "") ? "" : (" for datapoint element " + dpIndex)) + ". Called by panel: " + myPanelName()
    )
  );
}

public void throwIncorrectDatapointTypeError(string actualDP, string expectedDPT)
{
  throwError(
    makeError(
        "",
        PRIO_SEVERE,
        ERR_IMPL,
        2,
        "Open Library Error: Panel \"" + myPanelName() + "\" uses \"" + actualDP + "\" of type \"" + dpTypeName(actualDP) + "\", but expected a \"" + expectedDPT + "\""
    )
  );
}

// Use the "Data types for DPEs" reference table in the help documents
public void throwIncorrectDataTypeError(string dpe, int expectedType)
{
  throwError(
    makeError(
        "",
        PRIO_SEVERE,
        ERR_IMPL,
        2,
        "Open Library Error: Panel \"" + myPanelName() + "\" uses \"" + dpe + "\" of type \"" + dpElementType(dpe) + "\", but expected a \"" + expectedType + "\""
    )
  );
}
