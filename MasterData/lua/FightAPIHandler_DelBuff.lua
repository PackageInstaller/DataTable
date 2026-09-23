local this = {};

--处理AddBuff事件
function this:Handle(data)
    local fightAction = FightActionMgr:Apply(FightActionType.DelBuff,data); 
    return fightAction;
end

return this;