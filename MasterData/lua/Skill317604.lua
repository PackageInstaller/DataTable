-- 限域音波
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill317604 = oo.class(SkillBase)
function Skill317604:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill317604:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8407
	local count7 = SkillApi:GetAttr(self, caster, target,1,"speed")
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 317604
	self:AddTempAttr(SkillEffect[317604], caster, self.card, data, "damage",count7/500)
end
