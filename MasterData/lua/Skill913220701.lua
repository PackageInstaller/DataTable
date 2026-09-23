-- 刃 核心天使被动技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913220701 = oo.class(SkillBase)
function Skill913220701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill913220701:OnActionOver(caster, target, data)
	-- 8065
	if SkillJudger:CasterIsSummoner(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8220
	if SkillJudger:IsCanHurt(self, caster, target, true) then
	else
		return
	end
	-- 913220701
	if self:Rand(1500) then
		self:CallSkill(SkillEffect[913220701], caster, self.card, data, 913220101)
	end
end
