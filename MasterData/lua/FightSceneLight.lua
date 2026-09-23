--战斗场景灯光


function Awake()
    eventMgr = ViewEvent.New();
    
    eventMgr:AddListener(EventType.Fight_Scene_Light_State, OnFightSceneLight)
end

function OnFightSceneLight(state)
    CSAPI.SetGOActive(goLight,state);
end

function OnDestroy()
    eventMgr:ClearListener();
end