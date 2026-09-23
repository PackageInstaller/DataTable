--技能工具
SkillUtil = {};
local this = SkillUtil;

--是否可以Overload中使用
function this:IsCanOverload(skillType)
    return skillType ~= SkillType.Passive and skillType ~= SkillType.Summon and skillType ~= SkillType.Unite and skillType ~= SkillType.Transform;
end

--是否特殊技能(召唤、合体、变身)
function this:IsSpecialSkill(skillType)
    return skillType == SkillType.Summon or skillType == SkillType.Unite or skillType == SkillType.Transform;
end

function this:IsOverloadSkill(upgrade_type )
    return upgrade_type  == 4;
end
--function this:IsOverloadSkill(skillType)
--    return skillType == SkillType.OverLoad;
--end

function this:IsOverloadSkillId(skillId)
    local cfg = Cfgs.skill:GetByID(skillId);
    --return cfg and self:IsOverloadSkill(cfg.type)
    return cfg and self:IsOverloadSkill(cfg.upgrade_type)
end

return this;
