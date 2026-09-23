local this = {};

--添加角色
function this:Handle(data)   
    --LogError("演出" .. table.tostring(data));
    
    local fightAction = nil;
    if(data.key)then
        PlayerClient:SetOpenSummon();
        EventMgr.Dispatch(EventType.Guide_Trigger, data.key);
    else
        fightAction = FightActionMgr:Apply(FightActionType.StartPlay,data); 
    end

    local boxFightAction = FightActionMgr:Apply(FightActionType.MainQueueBox);  
    boxFightAction:SetFightAction(fightAction);
    return boxFightAction;
end

return this;