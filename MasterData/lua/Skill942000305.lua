-- 赤夕技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill942000305 = oo.class(SkillBase)
function Skill942000305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill942000305:DoSkill(caster, target, data)
	-- 704000305
	self.order = self.order + 1
	self:AddBuff(SkillEffect[704000305], caster, target, data, 704000304)
	-- 704000312
	self.order = self.order + 1
	self:Cure(SkillEffect[704000312], caster, target, data, 1,0.15)
end
