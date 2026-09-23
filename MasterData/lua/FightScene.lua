--战斗场景


function Awake()
    if(emissionUp)then
        actionEmissionUp = ComUtil.GetCom(emissionUp,"ActionBase");
    end
    if(emissionDown)then
        actionEmissionDown = ComUtil.GetCom(emissionDown,"ActionBase");
    end


    eventMgr = ViewEvent.New();
    
    eventMgr:AddListener(EventType.Fight_Scene_Emission_Up, OnFightSceneEmissionUp)
    eventMgr:AddListener(EventType.Fight_Scene_Emission_Down, OnFightSceneEmissionDown)    
end

function OnFightSceneEmissionUp()
    if(actionEmissionUp)then
        actionEmissionUp:Play();
    end
    --CSAPI.SetGOActive(emissionUp,true);
    --FuncUtil:Call(DisableLightAction,nil,1000);
end

function OnFightSceneEmissionDown()
    if(actionEmissionDown)then
        actionEmissionDown:Play();
    end
end

--function DisableLightAction()
--     CSAPI.SetGOActive(emissionUp,false);
--     CSAPI.SetGOActive(emissionDown,false);
--end

function OnDestroy()
    eventMgr:ClearListener();
end