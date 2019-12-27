#uses "aes.ctl"

int DMCopenAES( string screenConfig="aes_default", string module="WinCC_OA-AES", int action=AES_ACTION_AUTORUN, string fileName="" , int xPos = 0, int yPos = 0)
{

  const string aesPanel="dmcAES/DMC_AEScreen.pnl";
  dyn_string param;
  string scDpName="";
  bool bStayOnTop;
  dyn_string ds;
  dyn_float df;

  if (module != "FALSE" && module != "TRUE")                                             // module is used for stayOnTop Parameter
  {
     dpGetCache("_Config.SysMgmStayOnTop:_online.._value", bStayOnTop);
  }
  else
  {
     bStayOnTop = module;
     module = "WinCC_OA-AES";
  }



  // check whether screen config exists
  aes_getDpName4RealName( screenConfig, AES_DPTYPE_SCREEN, AESTYPE_GENERAL, scDpName );
  if( scDpName == "" )
  {
    //dialog - configuraion not found !!!
    return -1;
  }

  if( screenConfig != "" )
  {
    param=makeDynString(  AESREGDOLLAR_SCREENTYPE + ":" + screenConfig,
                          AESREGDOLLAR_ACTION + ":" + action,
                          AESREGDOLLAR_FILENAME + ":" + fileName );
  }

  // only for long time test
  if( g_longTest )
  {
    ChildPanelOnModalReturn( aesPanel, "AES LongTime", param, 0, 0, df, ds );
    return 0;
  }
  if( ! isModuleOpen( module ) )
  {
    ModuleOnWithPanel( module, xPos,yPos,0,0,0,0, "", aesPanel, "", param );
    if ( bStayOnTop)
    {
      stayOnTop ( TRUE, module);
    }
  }
  else
  {
    RootPanelOnModule(aesPanel, "", module,  param );
    if ( bStayOnTop)
    {
      stayOnTop (TRUE, module);
    }
  }


  return 0;  // OK
}
