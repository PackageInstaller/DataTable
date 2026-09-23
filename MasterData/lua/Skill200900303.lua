-- 荧荧奏曲
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200900303 = oo.class(SkillBase)
function Skill200900303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200900303:DoSkill(caster, target, data)
	-- 200900303
	self.order = self.order + 1
	self:Cure(SkillEffect[200900303], caster, target, data, 1,0.11)
	-- 200900312
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200900312], caster, target, data, 200900312,2)
end
