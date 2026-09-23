-- 灵风交响（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200801305 = oo.class(SkillBase)
function Skill200801305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200801305:DoSkill(caster, target, data)
	-- 200801305
	self.order = self.order + 1
	self:Cure(SkillEffect[200801305], caster, target, data, 1,0.34)
	-- 200801313
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200801313], caster, target, data, 200801313,2)
end
