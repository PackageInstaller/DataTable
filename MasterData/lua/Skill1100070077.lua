-- 共用血条机制挑战3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070077 = oo.class(SkillBase)
function Skill1100070077:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 战斗开始
function Skill1100070077:OnStart(caster, target, data)
	-- 11000700770
	self:SetInvincible(SkillEffect[11000700770], caster, target, data, 4,1,1553294,999)
end
-- 攻击结束
function Skill1100070077:OnAttackOver(caster, target, data)
	-- 912100002
	local angler2 = SkillApi:GetStateDamage(self, caster, self.card,nil)
	-- 11000700775
	if SkillJudger:GreaterEqual(self, caster, target, true,angler2,1553294) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 11000700772
	self:ForceOver(SkillEffect[11000700772], caster, self.card, data, 1)
end
-- 回合开始时
function Skill1100070077:OnRoundBegin(caster, target, data)
	-- 912100002
	local angler2 = SkillApi:GetStateDamage(self, caster, self.card,nil)
	-- 11000700775
	if SkillJudger:GreaterEqual(self, caster, target, true,angler2,1553294) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 11000700772
	self:ForceOver(SkillEffect[11000700772], caster, self.card, data, 1)
end
