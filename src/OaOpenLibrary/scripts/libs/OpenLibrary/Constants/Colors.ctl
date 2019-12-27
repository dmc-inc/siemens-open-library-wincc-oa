/*
 *
 *  WinCC OA Open Library
 *
 *  Author:     DMC, Inc. http://www.dmcinfo.com
 *
 *  File:       Colors.ctl
 *
 *  Revisions:  02/1/17 - Leigh Mathews (leigh.mathews@dmcinfo.com) :
 *                         Created
 *              01/25/19 - Nick Leisle (nicholas.leisle@dmcinfo.com):
 *                         Removed Enums from old OL_Globals and renamed file "Colors"
 *              02/19/19 - Nick Leisle (nicholas.leisle@dmcinfo.com):
 *                         Updated colors per new color DB
 *              03/15/19 - Nick Leisle (nicholas.leisle@dmcinfo.com):
 *                         Updated colors again (primarily device colors)
 *
 *  Description: Globally-used colors
 */

// Device Colors
public const string DEVICE_STOPPED_COLOR     = "OL_Device_Stopped";
public const string DEVICE_ERRORED_COLOR     = "OL_Device_Errored";
public const string DEVICE_FORWARD_COLOR     = "OL_Device_Forward";
public const string DEVICE_WORK_COLOR        = "OL_Device_Work";
public const string DEVICE_REVERSE_COLOR     = "OL_Device_Reverse";
public const string DEVICE_HOME_COLOR        = "OL_Device_Home";
public const string DEVICE_ON_FORWARD_COLOR  = "OL_Device_OnForward";
public const string DEVICE_ON_WORK_COLOR     = "OL_Device_OnWork";
public const string DEVICE_ON_REVERSE_COLOR  = "OL_Device_OnReverse";
public const string DEVICE_ON_HOME_COLOR     = "OL_Device_OnHome";

public const string DEVICE_INTERLOCKED_COLOR = "OL_Device_Interlocked";
public const string DEVICE_OFF_COLOR         = "OL_Device_Off";
public const string DEVICE_OUTLINE_LIGHT     = "OL_White";
public const string DEVICE_OUTLINE_DARK      = "OL_Grey";

// Status Colors
public const string WARNING_STATUS_COLOR = "OL_Status_Warning";
public const string OK_STATUS_COLOR      = "OL_Status_OK";
public const string ERROR_STATUS_COLOR   = "OL_Status_Error";

// System Mode Colors
public const string SYSTEM_INDEPEDENT_COLOR = "OL_SystemMode_Independent";
public const string SYSTEM_MANUAL_COLOR     = "OL_SystemMode_Manual";
public const string SYSTEM_AUTO_COLOR       = "OL_SystemMode_Auto";
public const string SYSTEM_STOPPED_COLOR    = "OL_SystemMode_Stopped";

// UI Element Colors
public const string BORDER_COLOR            = "OL_UI_Border";
public const string BUTTON_NEUTRAL_COLOR    = "OL_UI_ButtonNeutral";
public const string BUTTON_ACTIVE_COLOR     = "OL_UI_ButtonActive";
public const string BUTTON_ACTIVATING_COLOR = "OL_UI_ButtonActivating";
public const string BUTTON_ACTIVE_NEEDS_ATTENTION_COLOR = "OL_UI_ButtonActiveNeedsAttention";
public const string DARK_TEXT_COLOR         = "OL_UI_Dark_Text";
public const string LIGHT_TEXT_COLOR        = "OL_UI_Light_Text";
public const string DISABLED_COLOR          = "OL_UI_Disabled";
public const string MENU_BAR_COLOR          = "OL_UI_Menu_Bar";
public const string POPUP_BACKGROUND_COLOR  = "OL_UI_Popup_Background_Color";
public const string UNDEFINED_VALUE_COLOR   = "OL_UI_Undefined_Value";
public const string DP_DNE_COLOR            = "_dpdoesnotexist";

// Trend Colors
public const string TREND_COLOR_1 = "OL_Trend_1";
public const string TREND_COLOR_2 = "OL_Trend_2";
public const string TREND_COLOR_3 = "OL_Trend_3";
public const string TREND_COLOR_4 = "OL_Trend_4";
public const string TREND_COLOR_5 = "OL_Trend_5";
