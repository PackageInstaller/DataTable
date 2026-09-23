-- 提泽娜科达拉共用血条机制挑战1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913900505 = oo.class(SkillBase)
function Skill913900505:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 战斗开始
function Skill913900505:OnStart(caster, target, data)
	-- 913900550
	self:SetInvincible(SkillEffect[913900550], caster, target, data, 4,1,782151,999)
end
-- 攻击结束
function Skill913900505:OnAttackOver(caster, target, data)
	-- 912100002
	local angler2 = SkillApi:GetStateDamage(self, caster, self.card,nil)
	-- 913900555
	if SkillJudger:GreaterEqual(self, caster, target, true,angler2,782151) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 913900552
	self:ForceOver(SkillEffect[913900552], caster, self.card, data, 1)
end
-- 回合开始时
function Skill913900505:OnRoundBegin(caster, target, data)
	-- 912100002
	local angler2 = SkillApi:GetStateDamage(self, caster, self.card,nil)
	-- 913900555
	if SkillJudger:GreaterEqual(self, caster, target, true,angler2,782151) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 913900552
	self:ForceOver(SkillEffect[913900552], caster, self.card, data, 1)
end
