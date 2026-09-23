-- 灾祸破灭
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703200501 = oo.class(SkillBase)
function Skill703200501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill703200501:DoSkill(caster, target, data)
	-- 703200501
	self.order = self.order + 1
	self:AddBuff(SkillEffect[703200501], caster, self.card, data, 703200501)
end
