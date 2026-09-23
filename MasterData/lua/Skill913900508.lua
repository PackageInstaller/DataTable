-- 提泽娜科达拉共用血条机制挑战4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913900508 = oo.class(SkillBase)
function Skill913900508:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 战斗开始
function Skill913900508:OnStart(caster, target, data)
	-- 913900580
	self:SetInvincible(SkillEffect[913900580], caster, target, data, 4,1,4758429,999)
end
-- 攻击结束
function Skill913900508:OnAttackOver(caster, target, data)
	-- 912100002
	local angler2 = SkillApi:GetStateDamage(self, caster, self.card,nil)
	-- 913900585
	if SkillJudger:GreaterEqual(self, caster, target, true,angler2,4758429) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 913900582
	self:ForceOver(SkillEffect[913900582], caster, self.card, data, 1)
end
-- 回合开始时
function Skill913900508:OnRoundBegin(caster, target, data)
	-- 912100002
	local angler2 = SkillApi:GetStateDamage(self, caster, self.card,nil)
	-- 913900585
	if SkillJudger:GreaterEqual(self, caster, target, true,angler2,4758429) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 913900582
	self:ForceOver(SkillEffect[913900582], caster, self.card, data, 1)
end
