-- 实弹聚合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill904500301 = oo.class(SkillBase)
function Skill904500301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill904500301:DoSkill(caster, target, data)
	-- 904500301
	self.order = self.order + 1
	self:AddBuff(SkillEffect[904500301], caster, target, data, 904500301)
	-- 904500302
	self.order = self.order + 1
	self:ChangeSkill(SkillEffect[904500302], caster, target, data, 3,904500401)
end
