-- 共用血条机制挑战1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070075 = oo.class(SkillBase)
function Skill1100070075:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 战斗开始
function Skill1100070075:OnStart(caster, target, data)
	-- 11000700750
	self:SetInvincible(SkillEffect[11000700750], caster, target, data, 4,1,351195,999)
end
-- 攻击结束
function Skill1100070075:OnAttackOver(caster, target, data)
	-- 912100002
	local angler2 = SkillApi:GetStateDamage(self, caster, self.card,nil)
	-- 11000700755
	if SkillJudger:GreaterEqual(self, caster, target, true,angler2,351195) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 11000700752
	self:ForceOver(SkillEffect[11000700752], caster, self.card, data, 1)
end
-- 回合开始时
function Skill1100070075:OnRoundBegin(caster, target, data)
	-- 912100002
	local angler2 = SkillApi:GetStateDamage(self, caster, self.card,nil)
	-- 11000700755
	if SkillJudger:GreaterEqual(self, caster, target, true,angler2,351195) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 11000700752
	self:ForceOver(SkillEffect[11000700752], caster, self.card, data, 1)
end
