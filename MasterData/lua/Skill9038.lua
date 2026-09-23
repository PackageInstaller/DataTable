-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9038 = oo.class(SkillBase)
function Skill9038:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill9038:OnBorn(caster, target, data)
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[9045], caster, target, data, 9037)
	end
end
