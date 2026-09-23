-- 屏障护壁
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill801000201 = oo.class(SkillBase)
function Skill801000201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill801000201:DoSkill(caster, target, data)
	-- 801000202
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferTypeForce(SkillEffect[801000202], caster, target, data, 801000201)
	end
	-- 801000201
	self.order = self.order + 1
	self:OwnerAddBuff(SkillEffect[801000201], caster, target, data, 801000201)
end
