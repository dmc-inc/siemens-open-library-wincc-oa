/////////////////////////////////////////////////////////////////////////////
//
//  WinCC OA Open Library
//
//  Author:     DMC, Inc. http://www.dmcinfo.com
//
//  File:       OL_Macros.ctl
//
//  Revisions:  02/15/17 - Leigh Mathews (leigh.mathews@dmcinfo.com) :
//                         Created
//
//  Description: Macro functions to save repetition in panel code
//
/////////////////////////////////////////////////////////////////////////////

#uses "OpenLibrary/Enums/DirectionType"


//Changes orientation of panel objects (vertical vs. horizontal)
void changeOrientation(DirectionType orientation, dyn_string shapes)
{
  for (int i=1;i<=dynlen(shapes);i++)
  {
    setValue(shapes[i], "rotation", orientation == DirectionType::Horizontal ? 0 : 270);
  }
  return;
}

// Resizes any calling panel to the size of the provided shape
void resizePanelToShape(shape shapeToFit)
{
  // Get shape size
  int width, height;
  getValue(shapeToFit, "size", width, height);

  // Add border sizes... comes in as string "[solid,oneColor,JoinBevel,CapProjecting,2]". We want the last int for width
  string borderString = shapeToFit.border;
  borderString = strltrim(borderString, "[]");
  dyn_string borderStringTokens = strsplit(borderString, ",");
  int borderWidth = 0;// (int) borderStringTokens[dynlen(borderStringTokens)];

  setPanelSize(myModuleName(), myPanelName(), false, width + borderWidth, height + borderWidth);
}

// Given a dynamic string of colors, assign corrseponding "light" and "dark" colors to contrast (designed to select appropriate text color)
dyn_string generateContrastingColors(dyn_string colors,string lightCol = "OL_UI_Light_Text",string darkCol = "OL_UI_Dark_Text")
{
  int red, green, blue, alpha, math;
  //we will append contrasting colors (light or dark) to and then return the contColors array
  dyn_string contColors;

  //for each color passed in, analyze and select whether it's best contrasted by a light or dark color
  for (int i = 1; i<= dynlen(colors); i++)
  {
    //formula for calculating the percieved brightness of a color found at
    //http://www.nbdtech.com/Blog/archive/2008/04/27/Calculating-the-Perceived-Brightness-of-a-Color.aspx
    colorToRgb(colors[i], red, green, blue, alpha);
    math = (int) sqrt(.241*red*red + .691*green*green + .068*blue*blue);

    //Colors with a percieved brightness higher than 165 are considered "light" and will be paired with a darkCol
    //Visa versa for values less than or equal to 165
    contColors[i] = (math > 165)? darkCol : lightCol;
  }
  return contColors;
}
