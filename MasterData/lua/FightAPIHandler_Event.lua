local this = {};

--处理API组事件
function this:Handle(data)
    --LogError("API数据=========================");
    --LogError(data);
    local fightAction = FightActionMgr:Apply(FightActionType.API,data);    
    if(fightAction)then
        FightActionUtil:HanderSubFightAction(fightAction,data.datas);
        fightAction:PushSub(FightActionMgr:Apply(FightActionType.DeadChecker),4);
    end
    return fightAction;
end

return this;