-- 催化之光
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill318702 = oo.class(SkillBase)
function Skill318702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill318702:OnBefourHurt(caster, target, data)
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
	-- 8411
	local count11 = SkillApi:BuffCount(self, caster, target,1,1,2)
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 318702
	self:AddTempAttr(SkillEffect[318702], caster, self.card, data, "damage",count11*0.06)
end
