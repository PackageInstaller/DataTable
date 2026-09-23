-- 能量炮-α
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill801100101 = oo.class(SkillBase)
function Skill801100101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill801100101:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
	-- 80003
	self.order = self.order + 1
	self:AddSp(SkillEffect[80003], caster, caster, data, 20)
end
