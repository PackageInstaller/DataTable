local this = {};

--处理复活
function this:Handle(data)
    local fightAction = FightActionMgr:Apply(FightActionType.Revive,data);     
    return fightAction;

--    local fightAction = FightAction.New();
--    fightAction.actionType = CMD_TYPE.Revive;
--    fightAction.id = data.id;
--    fightAction.datas = { data.data };
--    return fightAction;
end

return this;