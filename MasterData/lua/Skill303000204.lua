-- 神圣审判
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill303000204 = oo.class(SkillBase)
function Skill303000204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill303000204:DoSkill(caster, target, data)
	-- 303000204
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferForce(SkillEffect[303000204], caster, target, data, 303000204)
	end
	-- 303000209
	self.order = self.order + 1
	self:AddBuff(SkillEffect[303000209], caster, target, data, 303000204)
end
