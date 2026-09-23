local this = {};

--处理OnStart事件
function this:Handle(data)
     if(FightClient:IsRestoreState())then
        return nil;
        --fightAction.queueType = QUEUE_TYPE.Green;
    end

    local fightAction = FightActionMgr:Apply(FightActionType.OnStart);
    FightActionUtil:HanderSubFightAction(fightAction,data.datas);
    --LogError(data);
   

    return fightAction;
end

return this;