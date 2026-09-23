local this = {};

--处理AddBuff事件
function this:Handle(data)
    local fightAction = FightActionMgr:Apply(FightActionType.AddBuff,data); 
    --挪到APIHander执行处
    --FightActionUtil:HanderSubFightAction(fightAction,data[BuffEvent_OnCreate]);
    return fightAction;
end

return this;