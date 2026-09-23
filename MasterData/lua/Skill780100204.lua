-- 洛贝拉2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill780100204 = oo.class(SkillBase)
function Skill780100204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill780100204:DoSkill(caster, target, data)
	-- 603300211
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferTypeForce(SkillEffect[603300211], caster, target, data, 603300201)
	end
	-- 603300204
	self.order = self.order + 1
	self:OwnerAddBuff(SkillEffect[603300204], caster, target, data, 603300204)
end
