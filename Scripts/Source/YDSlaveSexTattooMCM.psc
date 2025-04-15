Scriptname YDSlaveSexTattooMCM extends SKI_ConfigBase  

YDSlaveSexTattooScriptR Property SexTattooScriptR auto

GlobalVariable Property YDSlaveSexTattooModEnable auto ;MainControl

Event OnConfigInit()
    ModName = "YDSlaveTatsExtend"
    self.RefreshStrings()
EndEvent


Function RefreshStrings()
    Pages = new string[1]
    Pages[0] = "ModSetting"
endFunction


Event OnPageReset(string PageName)

    if(PageName=="")

    elseif(PageName=="ModSetting")
        CreatSettingsPage()
    endif

EndEvent

bool property StateMainControl auto
int MainControlOptionID = 0

bool property StateMeatToiletOption auto
int MeatToiletOptionID = 0

bool Property StateShowDebugOption Auto
int ShowDebugOptionID = 0


int OrgasmTextBlockID = 0
int StepOrgasmTextBlockID = 0

function CreatSettingsPage()
    SetCursorFillMode(TOP_TO_BOTTOM);
    SettingsPageLeft()
    SetCursorPosition(1)
    SettingsPageRight()
endFunction

Function SettingsPageLeft()
    AddHeaderOption("System")
    AddEmptyOption()

    Actor Player = Game.GetPlayer()

    int GetOrgasmCount = StorageUtil.GetIntValue(Player,"YDSexMeatToiletTotalOrgasm")
    OrgasmTextBlockID = AddTextOption("TotalOrgasmCount:",GetOrgasmCount,0)

    int GetStepOrgasmCount = StorageUtil.GetIntValue(Player,"YDSexMeatToiletOrgasmCount")
    StepOrgasmTextBlockID = AddTextOption("NeedOrgasmCount",GetStepOrgasmCount + "/3",0)

    MeatToiletOptionID = AddToggleOption("Add MeatToilet to Player",StateMeatToiletOption)
EndFunction

Function SettingsPageRight()
    AddHeaderOption("Debug")
    AddEmptyOption()
    ShowDebugOptionID = AddToggleOption("ShowDebugMsg",StateShowDebugOption)
    MainControlOptionID = AddToggleOption("Enable/Disable",StateMainControl)
EndFunction


Event OnOptionSelect(int ID)

    if(ID == MainControlOptionID)
        StateMainControl  =! StateMainControl 
        SetToggleOptionValue(ID, StateMainControl)   
    EndIf
    if(ID == MeatToiletOptionID)
         StateMeatToiletOption  =! StateMeatToiletOption
         SetToggleOptionValue(ID, StateMeatToiletOption)
    EndIf

    CheckValue(ID)

EndEvent

function CheckValue(int ID)

    if(ID == MeatToiletOptionID)

        ;Debug.Notification("MeatToiletOption")

        if(StateMeatToiletOption == true)
            ;Debug.Notification("AddEffect")
            SexTattooScriptR.YDAddTattoo(Game.GetPlayer(), "Promiscuous0", "YDTattoo\\body_slave_sign01_step_0_yd.dds", "YDSexMeatToilet", "Body", 0)
            SlaveTats.synchronize_tattoos(Game.GetPlayer())
        Else
            ;Debug.Notification("RemoveEffect")
            Actor Player = Game.GetPlayer()
            SlaveTats.simple_remove_tattoo(Player,"YDSexMeatToilet","Promiscuous0")
            SlaveTats.simple_remove_tattoo(Player,"YDSexMeatToilet","Promiscuous1")
            SlaveTats.simple_remove_tattoo(Player,"YDSexMeatToilet","Promiscuous2")
        endif
    endif
   
    if(ID == MainControlOptionID)

        ;Debug.Notification("MainControlOption")

        if(StateMainControl == true)
            YDSlaveSexTattooModEnable.SetValueInt(1)
            ;Debug.Notification("Start Service:" + YDSlaveSexTattooModEnable.GetValueInt())
         Else
            YDSlaveSexTattooModEnable.SetValueInt(-1)
            ;Debug.Notification("Close Service" + YDSlaveSexTattooModEnable.GetValueInt())
        endif 
    endif
  

endFunction