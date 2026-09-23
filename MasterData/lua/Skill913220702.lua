-- 刃 换皮虚蚀显化者被动技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913220702 = oo.class(SkillBase)
function Skill913220702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill913220702:OnActionOver(caster, target, data)
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
-- 战斗开始
function Skill913220702:OnStart(caster, target, data)
	-- 913220702
	if SkillJudger:IsCasterSibling(self, caster, target, true,91320) then
	else
		return
	end
end
