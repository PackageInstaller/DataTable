-- 霜质
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill925700401 = oo.class(SkillBase)
function Skill925700401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill925700401:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 922600401
	self:AddBuff(SkillEffect[922600401], caster, self.card, data, 922600401)
end
-- 行动结束
function Skill925700401:OnActionOver(caster, target, data)
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
	-- 922600402
	self:OwnerHitAddBuff(SkillEffect[922600402], caster, caster, data, 2500,3005,1)
end
-- 行动结束
function Skill925700401:OnActionOver(caster, target, data)
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
	-- 922600403
	self:OwnerHitAddBuff(SkillEffect[922600403], caster, target, data, 2500,3005,1)
end
