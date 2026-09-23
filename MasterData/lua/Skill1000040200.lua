-- 物攻词条
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1000040200 = oo.class(SkillBase)
function Skill1000040200:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill1000040200:OnAfterHurt(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1000040131
	if SkillJudger:HasBuff(self, caster, target, true,2,1000040010) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 1000040200
	if self:Rand(5000) then
		self:BeatBack(SkillEffect[1000040200], caster, self.card, data, nil)
	end
end
