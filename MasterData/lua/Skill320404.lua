-- 系统弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill320404 = oo.class(SkillBase)
function Skill320404:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击开始
function Skill320404:OnAttackBegin(caster, target, data)
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
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 8491
	local count91 = SkillApi:BuffCount(self, caster, target,2,4,50020)
	-- 8185
	if SkillJudger:Greater(self, caster, target, true,count91,0) then
	else
		return
	end
	-- 320404
	self:AddBuff(SkillEffect[320404], caster, target, data, 320404)
end
