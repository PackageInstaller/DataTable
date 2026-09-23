-- 耐寒特性
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill910800402 = oo.class(SkillBase)
function Skill910800402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill910800402:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 攻击结束
function Skill910800402:OnAttackOver(caster, target, data)
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
	-- 910800401
	self:OwnerAddBuffCount(SkillEffect[910800401], caster, target, data, 907700401,1,8)
end
-- 行动结束
function Skill910800402:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8616
	local count616 = SkillApi:GetBeDamage(self, caster, target,3)
	-- 8816
	if SkillJudger:Greater(self, caster, target, true,count616,0) then
	else
		return
	end
	-- 910800402
	self:HitAddBuff(SkillEffect[910800402], caster, caster, data, 10000,5004,2)
	-- 910800406
	self:HitAddBuff(SkillEffect[910800406], caster, caster, data, 10000,5204,2)
end
-- 行动结束2
function Skill910800402:OnActionOver2(caster, target, data)
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
	-- 8623
	local count623 = SkillApi:GetCount(self, caster, target,3,907700401)
	-- 8885
	if SkillJudger:GreaterEqual(self, caster, target, true,count623,4) then
	else
		return
	end
	-- 910800405
	self:BeatBack(SkillEffect[910800405], caster, target, data, 910800201)
	-- 907700404
	self:DelBufferForce(SkillEffect[907700404], caster, self.card, data, 907700401)
end
