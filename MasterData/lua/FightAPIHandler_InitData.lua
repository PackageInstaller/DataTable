local this = {};

--战斗数据初始化
function this:Handle(data)   
--    LogError("初始化战斗");
--    LogError(data);
    local fightAction = FightActionMgr:Apply(FightActionType.InitData,data);   
    return fightAction;
end

return this;