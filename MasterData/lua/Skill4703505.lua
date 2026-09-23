-- 哑迹
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4703505 = oo.class(SkillBase)
function Skill4703505:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4703505:OnAttackOver(caster, target, data)
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
	-- 4703503
	self:OwnerHitAddBuff(SkillEffect[4703503], caster, caster, data, 8000,3002,2)
end
-- 伤害后
function Skill4703505:OnAfterHurt(caster, target, data)
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
	-- 4703506
	self:OwnerHitAddBuff(SkillEffect[4703506], caster, target, data, 3000,3002,1)
end
