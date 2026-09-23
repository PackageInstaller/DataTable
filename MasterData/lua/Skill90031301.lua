-- 技能13
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill90031301 = oo.class(SkillBase)
function Skill90031301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill90031301:DoSkill(caster, target, data)
	-- 20003
	self.order = self.order + 1
	self:AddProgress(SkillEffect[20003], caster, target, data, 1000)
	-- 81003
	self.order = self.order + 1
	self:AddSp(SkillEffect[81003], caster, target, data, 50)
end
