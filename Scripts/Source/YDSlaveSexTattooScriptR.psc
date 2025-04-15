Scriptname YDSlaveSexTattooScriptR extends Quest  


Actor []ActorPool
int ActorCount = 0

Actor Function GetActor(int Offset)
    return ActorPool[Offset]
EndFunction

int Function GetActorCount()
    return ActorCount
EndFunction

bool Function FindActor(Actor Act)

    int i = 0

    while(i < ActorCount)

        if(ActorPool[i] == Act)
            return true
            i = ActorCount
        endif

        i+=1
    endwhile
    return false

endFunction

Function AddActor(Actor AddAct)
    if(ActorCount < 55)
 
       if(!FindActor(AddAct))
         ActorPool[ActorCount] = AddAct
         ActorCount+=1
       endif
 
       Else
         ; code
    endif
 endFunction

 Function DeleteActor(Actor Act)

    int i = 0
    int StartIndex = 0
    int LastItemOffset = ActorCount ;EMPTY Ptr
    bool FindThis = false

    while(i < ActorCount)

         if(ActorPool[i] == Act)

            StartIndex = i
            ActorPool[i] = ActorPool[LastItemOffset]
            FindThis = true
            i = ActorCount

         endif
         
         i+=1
    endwhile

    if(FindThis)
        SetActorToEnd(StartIndex)
        ActorCount-=1
    endif

endFunction

Function  InitActorPool() 
    ActorPool = New Actor[60] 
    ActorCount = 0
EndFunction


Function SetActorToEnd(int Index)
    
    int Offset = 0
    int i = 0

    while(i < ActorCount)
    
        if (i == Index)
            Offset+=1
        endif

        ActorPool[i] = ActorPool[Offset]
        Offset+=1
        i+=1

    endwhile

endFunction

Int Function RetainedMap() 
    Int map = JMap.object()
    JValue.retain(map)
    Return map
EndFunction

Int Function RetainedMap1Pair(String key1, String value1) 
    Int map = RetainedMap()
    JMap.setStr(map, key1, value1)
    return map
EndFunction

Int Function RetainedMap2Pair(String key1, String value1, String key2, String value2) 
    Int map = RetainedMap1Pair(key1, value1)
    JMap.setStr(map, key2, value2)
    return map
EndFunction

Int Function RetainedMap3Pair(String key1, String value1, String key2, String value2, String key3, String value3) 
    Int map = RetainedMap2Pair(key1, value1, key2, value2)
    JMap.setStr(map, key3, value3)
    return map
EndFunction

Int Function RetainedMap4Pair(String key1, String value1, String key2, String value2, String key3, String value3, String key4, String value4) 
    Int map = RetainedMap3Pair(key1, value1, key2, value2, key3, value3)
    JMap.setStr(map, key4, value4)
    return map
EndFunction


Int Function YDAddTattoo(Actor anActor, String name, String texture, String section, String area, Int slot, Int colorTint = -1) 
    ; AddTattoo(anActor, "Sob 2", "Sob Tears\\sob_2.dds", "Tears", "Face", slot)
    Int map =  RetainedMap4Pair("name", name, "texture", texture, "section", section, "area", area)
    If Slavetats.add_tattoo(anActor, map, slot,true,true)
        Debug.Notification("Failed to add tattoo")
    EndIf
    Return map
EndFunction

int Function YDFindTattoo(Actor Player,string FindName)

    int applied = JFormDB.getObj(Player, ".SlaveTats.applied")

    if applied == 0
        return -1
    endif

    int i = JArray.count(applied)
    while i > 0
        i -= 1

        int entry = JArray.getObj(applied, i)

        if ((JMap.getStr(entry, "area") != "") || (JMap.getInt(entry, "slot") != -1))
            ;Debug.Notification(JMap.getStr(entry, "name"))
            if(JMap.getStr(entry, "name") == FindName)
                return JMap.getInt(entry, "slot")
            endif
        endif

    endwhile

    return -1

EndFunction


Event OnSimpleAddTattoo(Form _form, String _section, String _name, int _color, bool _last, bool _silent)
	float _alpha = 1.0
    if !_form as Actor
		return
	endIf
EndEvent

Event OnAddTattoo(Form _form, String _section, String _name, int _color, bool _last, bool _silent, int _glowColor, bool _gloss, bool _lock)
	float _alpha = 1.0
	if !_form as Actor
		return
	endIf
EndEvent

Event OnSimpleRemoveTattoo(Form _form, String _section, String _name, bool _last, bool _silent)
    if !_form as Actor
		return
	endIf
EndEvent


Event OnRemoveAllSectionTattoo(Form _form, String _section, bool _ignoreLock, bool _silent)
	if !_form as Actor
		return
	endIf
EndEvent