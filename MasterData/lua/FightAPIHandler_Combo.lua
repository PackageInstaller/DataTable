local this = {};

--处理合体
function this:Handle(data)
    local fightAction = FightActionMgr:Apply(FightActionType.Combo,data);     
    return fightAction;

--    local fightAction = FightAction.New(CMD_TYPE.Combo);
--    fightAction.id = data.id;
--    fightAction.ids = data.ids;
--    fightAction.datas = data.datas;

--    return fightAction;
end

return this;