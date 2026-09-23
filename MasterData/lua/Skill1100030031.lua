-- 角色每段攻击积累标记，每20层引爆伤害，造成角色1500%真实
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100030031 = oo.class(SkillBase)
function Skill1100030031:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill1100030031:OnAfterHurt(caster, target, data)
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
	-- 1100030036
	self:OwnerAddBuffCount(SkillEffect[1100030036], caster, target, data, 1100030030,1,24)
end
-- 攻击结束
function Skill1100030031:OnAttackOver(caster, target, data)
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
	-- 1100030035
	local buxiubiaoji = SkillApi:GetCount(self, caster, target,2,1100030030)
	-- 1100030033
	if SkillJudger:Greater(self, caster, target, true,buxiubiaoji,15) then
	else
		return
	end
	-- 1100030037
	self:LimitDamage(SkillEffect[1100030037], caster, target, data, 0.2,15)
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
	-- 1100030032
	self:DelBufferForce(SkillEffect[1100030032], caster, target, data, 1100030030)
end
