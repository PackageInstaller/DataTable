-- 全体戒备
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703400204 = oo.class(SkillBase)
function Skill703400204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill703400204:DoSkill(caster, target, data)
	-- 703400204
	self.order = self.order + 1
	self:Cure(SkillEffect[703400204], caster, target, data, 1,0.08)
	-- 703400212
	self.order = self.order + 1
	self:AddBuff(SkillEffect[703400212], caster, target, data, 703400202,2)
end
