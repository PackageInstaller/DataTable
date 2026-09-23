-- 能量吸收
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill325301 = oo.class(SkillBase)
function Skill325301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill325301:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8074
	if SkillJudger:TargetIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 325301
	self:AddSp(SkillEffect[325301], caster, target, data, 5)
end
