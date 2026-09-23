-- 技能18
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill90031801 = oo.class(SkillBase)
function Skill90031801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill90031801:DoSkill(caster, target, data)
	-- 90011
	self.order = self.order + 1
	self:Transform(SkillEffect[90011], caster, target, data, {progress=1010})
end
