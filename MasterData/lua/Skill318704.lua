-- 催化之光
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill318704 = oo.class(SkillBase)
function Skill318704:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill318704:OnBefourHurt(caster, target, data)
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
	-- 318704
	self:AddTempAttr(SkillEffect[318704], caster, self.card, data, "damage",count11*0.12)
end
