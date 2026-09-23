-- 茶晶天赋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill329302 = oo.class(SkillBase)
function Skill329302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill329302:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8463
	local count63 = SkillApi:GetAttr(self, caster, target,3,"defense")
	-- 329302
	self:AddTempAttr(SkillEffect[329302], caster, self.card, data, "damage",count63/8000)
end
