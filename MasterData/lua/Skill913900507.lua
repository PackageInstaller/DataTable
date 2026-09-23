-- 提泽娜科达拉共用血条机制挑战3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913900507 = oo.class(SkillBase)
function Skill913900507:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 战斗开始
function Skill913900507:OnStart(caster, target, data)
	-- 913900570
	self:SetInvincible(SkillEffect[913900570], caster, target, data, 4,1,2795928,999)
end
-- 攻击结束
function Skill913900507:OnAttackOver(caster, target, data)
	-- 912100002
	local angler2 = SkillApi:GetStateDamage(self, caster, self.card,nil)
	-- 913900575
	if SkillJudger:GreaterEqual(self, caster, target, true,angler2,2795928) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 913900572
	self:ForceOver(SkillEffect[913900572], caster, self.card, data, 1)
end
-- 回合开始时
function Skill913900507:OnRoundBegin(caster, target, data)
	-- 912100002
	local angler2 = SkillApi:GetStateDamage(self, caster, self.card,nil)
	-- 913900575
	if SkillJudger:GreaterEqual(self, caster, target, true,angler2,2795928) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 913900572
	self:ForceOver(SkillEffect[913900572], caster, self.card, data, 1)
end
