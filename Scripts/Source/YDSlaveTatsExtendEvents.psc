Scriptname YDSlaveTatsExtendEvents extends ReferenceAlias  

YDSlaveSexTattooScriptR Property SexTattooScriptR auto
SexLabFramework Property SexLab Auto
GlobalVariable Property YDSlaveSexTattooModEnable auto ;MainControl

Event OnInit()
	StartYDListenService()
EndEvent

Event OnPlayerLoadGame()
	StartYDListenService()
EndEvent

Event YDSlaveTatsExtendOrgasmStart(String HookName, String ArgString, Float ArgNum, Form Sender)

	sslBaseAnimation animation = SexLab.HookAnimation(argString)
	Actor[] ActorArray = SexLab.HookActors(argString)
	Int NumberOfActors =  ActorArray .Length

	int Offset = 0
	int i = NumberOfActors
	While i >= 0
		Offset = i
		Actor CurrentPlayer = ActorArray[Offset]
		
		if(StorageUtil.GetIntValue(CurrentPlayer,"YDSexMeatToilet") == 1)
			If Animation.HasTag("Vaginal") || Animation.HasTag("Anal")

				debug.notification("YDMsg:" + CurrentPlayer.GetActorBase().GetName() + " have already orgasmed!")

                debug.notification("Amount of semen injected into the vagina:" + SexLab.CountCumVaginal(CurrentPlayer))
                debug.notification("Amount of semen injected into the anus:" + SexLab.CountCumAnal(CurrentPlayer))

				int TotalOrgasmCount = StorageUtil.GetIntValue(CurrentPlayer,"YDSexMeatToiletTotalOrgasm")
				TotalOrgasmCount = TotalOrgasmCount + 1
				StorageUtil.SetIntValue(CurrentPlayer,"YDSexMeatToiletTotalOrgasm",TotalOrgasmCount)

                int CurrentStepOrgasmCount = StorageUtil.GetIntValue(CurrentPlayer,"YDSexMeatToiletOrgasmCount")
                CurrentStepOrgasmCount = CurrentStepOrgasmCount + 1
                StorageUtil.SetIntValue(CurrentPlayer,"YDSexMeatToiletOrgasmCount", CurrentStepOrgasmCount)
			EndIf
		EndIf
		i -= 1
	EndWhile


EndEvent

Event YDSlaveTatsExtendOrgasmEnd(String HookName, String ArgString, Float ArgNum, Form Sender)

EndEvent



function StartYDListenService()
    UnregisterForModEvent("OrgasmStart")
    UnregisterForModEvent("OrgasmEnd")

    RegisterForModEvent("OrgasmStart", "YDSlaveTatsExtendOrgasmStart")
    RegisterForModEvent("OrgasmEnd", "YDSlaveTatsExtendOrgasmEnd")

    debug.notification("YDSlaveTatsExtend-InitSucess")
	
    UnregisterForUpdate()
    RegisterForUpdate(15)
endfunction

int CurrentUsingCount = 1
Event OnUpdate()
    int GetState = YDSlaveSexTattooModEnable.GetValueInt();
    
    if(GetState > 0)

        Actor Player = Game.GetPlayer()
        bool IsFind = false
            int GetPromiscuousaSort = SexTattooScriptR.YDFindTattoo(Player, "Promiscuous0")
            if(GetPromiscuousaSort>=0)
                ;Debug.Notification("You are currently a meat toilet and your libido is increasing..")
                IsFind = true
                float GetActAroused =  OSLArousedNative.GetArousal(Player)

                if(GetActAroused > 20)
    
                    SetButtScale(Player, 1.2)
                    SetBreastScale(Player,1.3)
    
                    SlaveTats.simple_remove_tattoo(Player,"YDSexMeatToilet","Promiscuous0")
                    SlaveTats.synchronize_tattoos(Player)
                    SexTattooScriptR.YDAddTattoo(Player, "Promiscuous1", "YDTattoo\\body_slave_sign01_step_1_yd.dds", "YDSexMeatToilet", "Body", GetPromiscuousaSort)
                    SlaveTats.synchronize_tattoos(Player)
                    ;Debug.Notification("Your tattoo is enhanced!")
    
                endif
                float NewActAroused = GetActAroused + 1.5
                ;Debug.Notification("Libido increased from " + GetActAroused + " to " + NewActAroused)
                OSLArousedNative.SetArousal(Player,NewActAroused)
            endif
    
            int GetPromiscuousBSort = SexTattooScriptR.YDFindTattoo(Player, "Promiscuous1")
            if(GetPromiscuousBSort>=0)
                ;Debug.Notification("You are currently a meat toilet and your libido is increasing..")
                IsFind = true
                    float GetActAroused =  OSLArousedNative.GetArousal(Player)
    
                    if(GetActAroused < 20)
    
                        SetButtScale(Player, 1)
                        SetBreastScale(Player,1)
    
                        SlaveTats.simple_remove_tattoo(Player,"YDSexMeatToilet","Promiscuous1")
                        SlaveTats.synchronize_tattoos(Player)
                        SexTattooScriptR.YDAddTattoo(Player, "Promiscuous0", "YDTattoo\\body_slave_sign01_step_0_yd.dds", "YDSexMeatToilet", "Body", GetPromiscuousBSort)
                        SlaveTats.synchronize_tattoos(Player)
                        ;Debug.Notification("your tattoo is cooling down!")
                    else
                        if(GetActAroused > 50)
    
							SetButtScale(Player, 1.5)
							SetBreastScale(Player,1.5)
    
                            float GetBaseLine = OSLArousedNative.GetLibido(Player)
                            GetBaseLine += 0.5
                            OSLArousedNative.SetLibido(Player,GetBaseLine)
                            ;Debug.Notification("Your body is thoroughly disciplined with slave tattoos...")
    
                            SlaveTats.simple_remove_tattoo(Player,"YDSexMeatToilet","Promiscuous1")
                            SlaveTats.synchronize_tattoos(Player)
    
                            SexTattooScriptR.YDAddTattoo(Player, "Promiscuous2", "YDTattoo\\body_slave_sign01_step_2_yd.dds", "YDSexMeatToilet", "Body", GetPromiscuousBSort)
                            SlaveTats.synchronize_tattoos(Player)
    
                            ;Debug.Notification("Your tattoo is enhanced!")
    
                        endif
    
                        float NewActAroused = GetActAroused + 2.5
                        ;Debug.Notification("Libido increased from " + GetActAroused + " to " + NewActAroused)
                        OSLArousedNative.SetArousal(Player,NewActAroused)
                    endif
            endif
    
            int GetPromiscuousCSort = SexTattooScriptR.YDFindTattoo(Player, "Promiscuous2")

            if(GetPromiscuousCSort>=0)
                ;Debug.Notification("You are currently a meat toilet and your libido is increasing..")
                IsFind = true
                float GetActAroused =  OSLArousedNative.GetArousal(Player)

                int GetOrgasmCount = StorageUtil.GetIntValue(Player,"YDSexMeatToiletOrgasmCount")

                if(GetOrgasmCount < 3)
                    float GetBaseLine = OSLArousedNative.GetLibido(Player)
                    GetBaseLine += 0.2
                    OSLArousedNative.SetLibido(Player,GetBaseLine)
        
                    float NewActAroused = GetActAroused + 3.5
                    OSLArousedNative.SetArousal(Player,NewActAroused)

                    Debug.Notification("Actor:" + Player.GetActorBase().GetName() + " semen is only "+ GetOrgasmCount +", and a promiscuous tattoo requires you to have at least 3 semen in your body to avoid punishment")
                    Debug.Notification("YDMsg:Punish Actor:" +  Player.GetActorBase().GetName()  + " Add PlayerBaseLine")
                    ;Debug.Notification("Libido increased from " + GetActAroused + " to " + NewActAroused)
                else
                    if(GetActAroused < 20)

                        SetButtScale(Player, 1.2)
                        SetBreastScale(Player,1.3)
    
                        OSLArousedNative.SetArousal(Player,30)
    
                        SlaveTats.simple_remove_tattoo(Player,"YDSexMeatToilet","Promiscuous2")
                        SlaveTats.synchronize_tattoos(Player)
                        SexTattooScriptR.YDAddTattoo(Player, "Promiscuous1", "YDTattoo\\body_slave_sign01_step_1_yd.dds", "YDSexMeatToilet", "Body", GetPromiscuousCSort)
                        SlaveTats.synchronize_tattoos(Player)
    
                        StorageUtil.SetIntValue(Player,"YDSexMeatToiletOrgasmCount",0)
                        ;Debug.Notification("your tattoo is cooling down!")
                    else
                endif
                   
                endif
            endif
            
            if(!IsFind)
                if(CurrentUsingCount > 0)
                    CurrentUsingCount = CurrentUsingCount - 1
					
					StorageUtil.SetIntValue(Player,"YDSexMeatToilet",0)
					
                    SetButtScale(Player, 1)
                    SetBreastScale(Player,1)
                endif   
            else
                CurrentUsingCount = 1

				if(StorageUtil.GetIntValue(Game.GetPlayer(),"YDSexMeatToilet")!=1)
					StorageUtil.SetIntValue(Game.GetPlayer(),"YDSexMeatToilet",1);
				endif

            EndIf

    else
        
    endif
  
EndEvent

Float Property ButtScaleMax = 5.0 Auto

Function SetButtScale(Actor Player, Float Value)
	If (Game.GetModbyName("SexLab Inflation Framework.esp") != 255)
        SLIFSetMaximum(Player, "slif_butt", ButtScaleMax)
		SLIFInflateActor(Player, "slif_butt", Value)
		;Debug.Notification("Change Body Sucess, Value:" + Value)
	EndIf
EndFunction

Float Property BreastScaleMax = 5.0 Auto

Function SetBreastScale(Actor Player, Float Value)
	If (Game.GetModbyName("SexLab Inflation Framework.esp") != 255)
        SLIFSetMaximum(Player, "slif_breast", BreastScaleMax)
		SLIFInflateActor(Player, "slif_breast", Value)
		;Debug.Notification("Change Body Sucess, Value:" + Value)
	EndIf
EndFunction

Float Property BellyScaleMax = 5.0 Auto

Function SetBellyScale(Actor Player, Float Value)
    If (Game.GetModbyName("SexLab Inflation Framework.esp") != 255)
        SLIFSetMaximum(Player, "slif_belly",  BellyScaleMax)
		SLIFInflateActor(Player, "slif_belly", Value)
		;Debug.Notification("Change Body Sucess, Value:" + Value)
    endIf
EndFunction 

Function SLIFSetMinimum(Actor kActor, String sKey, float value)
	int SLIF_event = ModEvent.Create("SLIF_setMinimum")
	If (SLIF_event)
		ModEvent.PushForm(SLIF_event, kActor)
		ModEvent.PushString(SLIF_event, "YD Slave Tats Extend Event")
		ModEvent.PushString(SLIF_event, sKey)
		ModEvent.PushFloat(SLIF_event, value)
		ModEvent.Send(SLIF_event)
	EndIf
EndFunction

Function SLIFSetMaximum(Actor kActor, String sKey, float value)
	int SLIF_event = ModEvent.Create("SLIF_setMaximum")
	If (SLIF_event)
		ModEvent.PushForm(SLIF_event, kActor)
		ModEvent.PushString(SLIF_event, "YD Slave Tats Extend Event")
		ModEvent.PushString(SLIF_event, sKey)
		ModEvent.PushFloat(SLIF_event, value)
		ModEvent.Send(SLIF_event)
	EndIf
EndFunction

Function SLIFInflateActor(Actor kActor, String sKey, float value)
	int SLIF_event = ModEvent.Create("SLIF_inflate")
	If (SLIF_event)
		ModEvent.PushForm(SLIF_event, kActor)
		ModEvent.PushString(SLIF_event, "YD Slave Tats Extend Event")
		ModEvent.PushString(SLIF_event, sKey)
		ModEvent.PushFloat(SLIF_event, value)
		ModEvent.PushString(SLIF_event, "YDSexSlaveR")
		ModEvent.Send(SLIF_event)
	EndIf
EndFunction


Function SLIFResetActor(Actor kActor, String sKey = "", float value = 1.0)
	int SLIF_event = ModEvent.Create("SLIF_resetActor")
	If (SLIF_event)
		ModEvent.PushForm(SLIF_event, kActor)
		ModEvent.PushString(SLIF_event, "YD Slave Tats Extend Event")
		ModEvent.PushString(SLIF_event, sKey)
		ModEvent.PushFloat(SLIF_event, value)
		ModEvent.PushString(SLIF_event, "YDSexSlaveR")
		ModEvent.Send(SLIF_event)
	EndIf
EndFunction