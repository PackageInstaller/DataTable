local this = {};

--处理API事件
function this:Handle(data)
--    LogError("Update Cage 数据=========================");
--    LogError(data);
    local character = CharacterMgr:Get(data.targetID);
    if(character)then
        character.SetCageDamage(data.damage);
        --LogError("设置牢笼伤害" .. tostring(data.damage));
    end
    

    local fightAction = FightActionMgr:Apply(FightActionType.API,data);   
    return fightAction;
end

return this;