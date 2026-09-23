-- 提泽纳boss技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913800201 = oo.class(SkillBase)
function Skill913800201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill913800201:DoSkill(caster, target, data)
	-- 12003
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12003], caster, target, data, 0.333,3)
end
-- 回合开始时
function Skill913800201:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 913800201
	self:DelBuffQuality(SkillEffect[913800201], caster, self.card, data, 2,1)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 913800202
	self:CallOwnerSkill(SkillEffect[913800202], caster, self.card, data, 913800501)
end
