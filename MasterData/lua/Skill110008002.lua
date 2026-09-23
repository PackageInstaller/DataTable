-- 普攻伤害增加20%，伤害后60%概率再次普攻攻击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill110008002 = oo.class(SkillBase)
function Skill110008002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill110008002:OnRoundBegin(caster, target, data)
	-- 110008002
	self:AddBuff(SkillEffect[110008002], caster, self.card, data, 110008002)
end
-- 伤害后
function Skill110008002:OnAfterHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 110008003
	if self:Rand(6000) then
		self:BeatAgain(SkillEffect[110008003], caster, target, data, nil)
	end
end
