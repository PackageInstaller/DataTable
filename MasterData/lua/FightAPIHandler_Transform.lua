local this = {};

--处理变身事件
function this:Handle(data)
  
    local fightAction = FightActionMgr:Apply(FightActionType.Transform,data);   
    return fightAction;
end

return this;