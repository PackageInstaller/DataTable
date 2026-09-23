-- 荆棘绽放
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill314703 = oo.class(SkillBase)
function Skill314703:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill314703:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 8402
	local count2 = SkillApi:LiveCount(self, caster, target,2)
	-- 314703
	self:AddTempAttr(SkillEffect[314703], caster, self.card, data, "damage",count2*0.03)
end
