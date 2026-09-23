-- 提泽娜科达拉共用血条机制挑战5
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913900509 = oo.class(SkillBase)
function Skill913900509:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 战斗开始
function Skill913900509:OnStart(caster, target, data)
	-- 913900590
	self:SetInvincible(SkillEffect[913900590], caster, target, data, 4,1,6271071,999)
end
-- 攻击结束
function Skill913900509:OnAttackOver(caster, target, data)
	-- 912100002
	local angler2 = SkillApi:GetStateDamage(self, caster, self.card,nil)
	-- 913900595
	if SkillJudger:GreaterEqual(self, caster, target, true,angler2,6271071) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 913900592
	self:ForceOver(SkillEffect[913900592], caster, self.card, data, 1)
end
-- 回合开始时
function Skill913900509:OnRoundBegin(caster, target, data)
	-- 912100002
	local angler2 = SkillApi:GetStateDamage(self, caster, self.card,nil)
	-- 913900595
	if SkillJudger:GreaterEqual(self, caster, target, true,angler2,6271071) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 913900592
	self:ForceOver(SkillEffect[913900592], caster, self.card, data, 1)
end
