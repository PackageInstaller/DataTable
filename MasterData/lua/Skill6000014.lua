-- 连锁阵线第二期buff1（群体伤害增益）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6000014 = oo.class(SkillBase)
function Skill6000014:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill6000014:OnAfterHurt(caster, target, data)
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
	-- 8203
	if SkillJudger:IsSingle(self, caster, target, false) then
	else
		return
	end
	-- 320816
	self:LimitDamage(SkillEffect[320816], caster, target, data, 0.01,0.5)
end
-- 死亡时
function Skill6000014:OnDeath(caster, target, data)
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
	-- 6000014
	self:AddBuffCount(SkillEffect[6000014], caster, self.card, data, 6000014,1,20)
end
