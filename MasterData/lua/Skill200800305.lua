-- 灵风交响
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200800305 = oo.class(SkillBase)
function Skill200800305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200800305:DoSkill(caster, target, data)
	-- 200800305
	self.order = self.order + 1
	self:Cure(SkillEffect[200800305], caster, target, data, 1,0.20)
	-- 200800313
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200800313], caster, target, data, 200800313,2)
end
