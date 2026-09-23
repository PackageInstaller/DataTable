-- 特技强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill324505 = oo.class(SkillBase)
function Skill324505:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill324505:OnBefourHurt(caster, target, data)
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
	-- 8407
	local count7 = SkillApi:GetAttr(self, caster, target,1,"speed")
	-- 324505
	self:AddTempAttr(SkillEffect[324505], caster, self.card, data, "damage",count7*0.003)
end
