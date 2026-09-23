local this = {};

--添加角色
function this:Handle(data)   
    local fightAction = FightActionMgr:Apply(FightActionType.AddCard,data.data);      
    return fightAction;
end

return this;