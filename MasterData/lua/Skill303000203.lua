-- 神圣审判
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill303000203 = oo.class(SkillBase)
function Skill303000203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill303000203:DoSkill(caster, target, data)
	-- 303000203
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferForce(SkillEffect[303000203], caster, target, data, 303000203)
	end
	-- 303000208
	self.order = self.order + 1
	self:AddBuff(SkillEffect[303000208], caster, target, data, 303000203)
end
