local this = {};

--特殊的处理API组事件
function this:Handle(data)
    local fightAction = FightActionMgr:Apply(FightActionType.APISpecial,data);
    FightActionUtil:HanderSubFightAction(fightAction,data.datas);
    --fightAction:PushSub(FightActionMgr:Apply(FightActionType.DeadChecker),4);
    return fightAction;
end

return this;