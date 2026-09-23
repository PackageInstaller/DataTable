-- 灵风交响
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200800301 = oo.class(SkillBase)
function Skill200800301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200800301:DoSkill(caster, target, data)
	-- 200800301
	self.order = self.order + 1
	self:Cure(SkillEffect[200800301], caster, target, data, 1,0.18)
	-- 200800311
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200800311], caster, target, data, 200800311,2)
end
