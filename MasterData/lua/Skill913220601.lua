-- 刃 天使被动技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913220601 = oo.class(SkillBase)
function Skill913220601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill913220601:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8075
	if SkillJudger:TargetIsSummoner(self, caster, target, true) then
	else
		return
	end
	-- 913220601
	if self:Rand(3000) then
		self:CallSkill(SkillEffect[913220601], caster, target, data, 913220201)
	end
end
