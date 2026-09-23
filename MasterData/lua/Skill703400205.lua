-- 全体戒备
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703400205 = oo.class(SkillBase)
function Skill703400205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill703400205:DoSkill(caster, target, data)
	-- 703400205
	self.order = self.order + 1
	self:Cure(SkillEffect[703400205], caster, target, data, 1,0.08)
	-- 703400213
	self.order = self.order + 1
	self:AddBuff(SkillEffect[703400213], caster, target, data, 703400203,2)
end
