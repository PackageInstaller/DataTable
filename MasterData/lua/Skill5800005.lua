-- 世界boss词条buff5
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5800005 = oo.class(SkillBase)
function Skill5800005:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill5800005:OnBefourHurt(caster, target, data)
	-- 8064
	if SkillJudger:CasterIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 5800019
	self:AddTempAttr(SkillEffect[5800019], caster, caster, data, "damage",0.5)
end
-- 特殊入场时(复活，召唤，合体)
function Skill5800005:OnBornSpecial(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8064
	if SkillJudger:CasterIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 5800020
	self:AddSkill(SkillEffect[5800020], caster, caster, data, 5800005)
end
