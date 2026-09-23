-- 弱点洞悉
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill325802 = oo.class(SkillBase)
function Skill325802:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill325802:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 8451
	local count51 = SkillApi:BuffCount(self, caster, target,2,4,22)
	-- 8129
	if SkillJudger:Greater(self, caster, target, true,count51,0) then
	else
		return
	end
	-- 325802
	self:AddTempAttr(SkillEffect[325802], caster, self.card, data, "damage",0.2)
end
