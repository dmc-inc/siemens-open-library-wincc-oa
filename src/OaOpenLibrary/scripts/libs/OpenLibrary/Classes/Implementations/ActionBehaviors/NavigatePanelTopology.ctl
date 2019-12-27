/**
  * WinCC OA Open Library
  * @author DMC, Inc. http://www.dmcinfo.com
  *
  * File: NavigatePanelTopology.ctl
  *
  * @description
  * This behavior allows navigation through panel topology via Node Name
  * Note that panel topology must be properly configured
  * Additional properties are also available, including parent nodes (creating a tree structure) and descriptions through the PanelTopology internal datapoint.
  * To access them, allocate their type and pass them by reference into the dpGet in this constructor
*/

#uses "OpenLibrary/Classes/Interfaces/Behaviors/IActionBehavior"

class NavigatePanelTopologyActionBehaviorClass : IActionBehaviorClass
{
  private static const string PANEL_TOPOLOGY = "_PanelTopology";
  private int panelId;

  public NavigatePanelTopologyActionBehaviorClass(string nodeName)
  {
    int arrayIndex;
    dyn_string nameArray;
    dyn_int idArray;

    dpGet(
        PANEL_TOPOLOGY + ".nodeName", nameArray,
        PANEL_TOPOLOGY + ".panelNumber", idArray
      );

    //Acquire the index of the desired panel in the nameArray
    int arrayIndex = dynContains(nameArray, nodeName);
    this.panelId = (arrayIndex == 0 ) ? -1 : idArray[arrayIndex];
  }

  public bool invoke()
  {
    if (this.panelId < 0)
    {
      return false;
    }
    pt_panelOn3(
        this.panelId,
        myModuleName());
    return true;
  }
};
