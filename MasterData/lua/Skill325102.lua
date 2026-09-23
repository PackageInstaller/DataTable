-- 命中伤害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill325102 = oo.class(SkillBase)
function Skill325102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill325102:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8620
	local count620 = SkillApi:GetAttr(self, caster, target,3,"hit")
	-- 325102
	self:AddTempAttr(SkillEffect[325102], caster, self.card, data, "damage",count620*0.2)
end
