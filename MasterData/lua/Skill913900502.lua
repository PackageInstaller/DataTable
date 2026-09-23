-- 提泽娜科达拉共用血条机制1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913900502 = oo.class(SkillBase)
function Skill913900502:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 战斗开始
function Skill913900502:OnStart(caster, target, data)
	-- 913900520
	self:SetInvincible(SkillEffect[913900520], caster, target, data, 4,1,103425,999)
end
-- 攻击结束
function Skill913900502:OnAttackOver(caster, target, data)
	-- 912100002
	local angler2 = SkillApi:GetStateDamage(self, caster, self.card,nil)
	-- 913900525
	if SkillJudger:GreaterEqual(self, caster, target, true,angler2,103425) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 913900522
	self:ForceOver(SkillEffect[913900522], caster, self.card, data, 1)
end
-- 回合开始时
function Skill913900502:OnRoundBegin(caster, target, data)
	-- 912100002
	local angler2 = SkillApi:GetStateDamage(self, caster, self.card,nil)
	-- 913900525
	if SkillJudger:GreaterEqual(self, caster, target, true,angler2,103425) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 913900522
	self:ForceOver(SkillEffect[913900522], caster, self.card, data, 1)
end
