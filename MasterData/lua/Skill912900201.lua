-- 类物拟态海生物·Ⅱ型_Mimic sea creature type Ⅱ
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill912900201 = oo.class(SkillBase)
function Skill912900201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill912900201:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 912900201
	self.order = self.order + 1
	self:AddLightShieldCount(SkillEffect[912900201], caster, self.card, data, 2309,2,10)
end
