-- 精神催进
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill701100203 = oo.class(SkillBase)
function Skill701100203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill701100203:DoSkill(caster, target, data)
	-- 701100203
	self.order = self.order + 1
	self:AddProgress(SkillEffect[701100203], caster, target, data, 400)
	-- 701100206
	self.order = self.order + 1
	self:DelBufferGroup(SkillEffect[701100206], caster, target, data, 1,5)
end
