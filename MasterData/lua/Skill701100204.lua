-- 精神催进
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill701100204 = oo.class(SkillBase)
function Skill701100204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill701100204:DoSkill(caster, target, data)
	-- 701100204
	self.order = self.order + 1
	self:AddProgress(SkillEffect[701100204], caster, target, data, 450)
	-- 701100206
	self.order = self.order + 1
	self:DelBufferGroup(SkillEffect[701100206], caster, target, data, 1,5)
end
