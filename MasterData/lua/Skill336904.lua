-- 提泽纳2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill336904 = oo.class(SkillBase)
function Skill336904:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill336904:OnAttackOver(caster, target, data)
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
	-- 336904
	if self:Rand(8000) then
		self:AlterRandBufferByID(SkillEffect[336904], caster, target, data, 1001,1)
	end
end
