-- 哑迹
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4703503 = oo.class(SkillBase)
function Skill4703503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4703503:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4703502
	self:OwnerHitAddBuff(SkillEffect[4703502], caster, caster, data, 6000,3002,2)
end
-- 伤害后
function Skill4703503:OnAfterHurt(caster, target, data)
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
	-- 4703505
	self:OwnerHitAddBuff(SkillEffect[4703505], caster, target, data, 2500,3002,1)
end
