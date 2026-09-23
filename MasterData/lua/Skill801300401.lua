-- 军团战魂
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill801300401 = oo.class(SkillBase)
function Skill801300401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill801300401:DoSkill(caster, target, data)
	-- 4801311
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4801311], caster, target, data, 4801301)
end
