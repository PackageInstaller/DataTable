local this = {};

--处理解体
function this:Handle(data)
    local fightAction = FightActionMgr:Apply(FightActionType.ComboBreak,data);     
    return fightAction;

--     local fightAction = FightAction.New();
--    fightAction.actionType = CMD_TYPE.ComboBreak;
--    fightAction.id = data.id;
--    fightAction.datas = data.datas;
--    return fightAction;
end

return this;