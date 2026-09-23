local this = {};

--处理回合切换
function this:Handle(data)    
    local fightAction = FightActionMgr:Apply(FightActionType.Turn,data);   
    --FightActionUtil:HanderSubFightAction(fightAction,data.datas);

    return fightAction;
end

return this;