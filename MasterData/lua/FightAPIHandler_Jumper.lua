local this = {};

--处理特殊排队的API事件
function this:Handle(data)
--    LogError("添加=======");
--    LogError(data);
    local fightAction = FightActionMgr:Apply(FightActionType.Jumper,data);   
    return fightAction;
end

return this;