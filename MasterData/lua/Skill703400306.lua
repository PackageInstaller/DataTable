-- 阵地构造
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703400306 = oo.class(SkillBase)
function Skill703400306:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill703400306:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 703400501
	self.order = self.order + 1
	self:Cure(SkillEffect[703400501], caster, target, data, 3,4)
	-- 92015
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[92015], caster, self.card, data, 2,2)
end
