-- 火力交错
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill501400301 = oo.class(SkillBase)
function Skill501400301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill501400301:DoSkill(caster, target, data)
	-- 12004
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12004], caster, target, data, 0.25,4)
	-- 4926
	self.order = self.order + 1
	local targets = SkillFilter:MinPercentHp(self, caster, target, 1,"hp",2)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[4926], caster, target, data, 4906)
	end
end
