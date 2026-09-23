-- 提泽娜科达拉共用血条机制2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913900503 = oo.class(SkillBase)
function Skill913900503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 战斗开始
function Skill913900503:OnStart(caster, target, data)
	-- 913900530
	self:SetInvincible(SkillEffect[913900530], caster, target, data, 4,1,320237,999)
end
-- 攻击结束
function Skill913900503:OnAttackOver(caster, target, data)
	-- 912100002
	local angler2 = SkillApi:GetStateDamage(self, caster, self.card,nil)
	-- 913900535
	if SkillJudger:GreaterEqual(self, caster, target, true,angler2,320237) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 913900532
	self:ForceOver(SkillEffect[913900532], caster, self.card, data, 1)
end
-- 回合开始时
function Skill913900503:OnRoundBegin(caster, target, data)
	-- 912100002
	local angler2 = SkillApi:GetStateDamage(self, caster, self.card,nil)
	-- 913900535
	if SkillJudger:GreaterEqual(self, caster, target, true,angler2,320237) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 913900532
	self:ForceOver(SkillEffect[913900532], caster, self.card, data, 1)
end
