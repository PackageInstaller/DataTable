local this = {};

--处理Miss事件
function this:Handle(data)
    local fightAction = FightActionMgr:Apply(FightActionType.MissBuff,data); 
    --FightActionUtil:HanderSubFightAction(fightAction,data);
    return fightAction;
end

return this;