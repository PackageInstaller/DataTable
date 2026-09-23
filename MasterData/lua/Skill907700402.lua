-- 耐寒特性
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill907700402 = oo.class(SkillBase)
function Skill907700402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill907700402:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 攻击结束
function Skill907700402:OnAttackOver(caster, target, data)
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
	-- 907700401
	self:OwnerAddBuffCount(SkillEffect[907700401], caster, target, data, 907700401,1,8)
end
-- 伤害前
function Skill907700402:OnBefourHurt(caster, target, data)
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
	-- 8434
	local count34 = SkillApi:BuffCount(self, caster, target,2,3,3005)
	-- 8117
	if SkillJudger:Greater(self, caster, self.card, true,count34,0) then
	else
		return
	end
	-- 907700402
	self:AddTempAttr(SkillEffect[907700402], caster, self.card, data, "damage",0.4)
end
-- 行动结束
function Skill907700402:OnActionOver(caster, target, data)
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
	-- 907700405
	self:BeatBack(SkillEffect[907700405], caster, target, data, 907700201)
	-- 907700404
	self:DelBufferForce(SkillEffect[907700404], caster, self.card, data, 907700401)
end
