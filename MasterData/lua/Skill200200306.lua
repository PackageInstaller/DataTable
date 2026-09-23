-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200200306 = oo.class(SkillBase)
function Skill200200306:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200200306:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200200306], caster, target, data, 200200306)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200200316], caster, target, data, 200200316)
end
