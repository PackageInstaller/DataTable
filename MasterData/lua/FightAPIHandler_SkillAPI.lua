local this = {};

--技能过程处理API组事件
function this:Handle(data)
    local fightAction = FightActionMgr:Apply(FightActionType.SkillAPI,data);
    --FightActionUtil:HanderSubFightAction(fightAction,data.datas);
    --fightAction:PushSub(FightActionMgr:Apply(FightActionType.DeadChecker),4);
    return fightAction;
end

return this;