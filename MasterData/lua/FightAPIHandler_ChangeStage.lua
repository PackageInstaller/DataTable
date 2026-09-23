local this = {};

--切换周目
function this:Handle(data)
    local fightAction = FightActionMgr:Apply(FightActionType.ChangeStage,data);
    local createFightAction = FightActionMgr:Apply(FightActionType.AddCard,data.datas)
    fightAction:PushSub(createFightAction);

    FightActionUtil:SetServerDatasHangUpState(true);
    CSAPI.DisableInput(10000);
    return fightAction;
end

return this;