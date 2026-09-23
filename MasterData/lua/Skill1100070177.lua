-- 共用血条机制血量8
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070177 = oo.class(SkillBase)
function Skill1100070177:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 战斗开始
function Skill1100070177:OnStart(caster, target, data)
	-- 11000701770
	self:SetInvincible(SkillEffect[11000701770], caster, target, data, 4,1,6553294,999)
end
-- 攻击结束
function Skill1100070177:OnAttackOver(caster, target, data)
	-- 912100002
	local angler2 = SkillApi:GetStateDamage(self, caster, self.card,nil)
	-- 11000701775
	if SkillJudger:GreaterEqual(self, caster, target, true,angler2,6553294) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 11000701772
	self:ForceOver(SkillEffect[11000701772], caster, self.card, data, 1)
end
-- 回合开始时
function Skill1100070177:OnRoundBegin(caster, target, data)
	-- 912100002
	local angler2 = SkillApi:GetStateDamage(self, caster, self.card,nil)
	-- 11000701775
	if SkillJudger:GreaterEqual(self, caster, target, true,angler2,6553294) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 11000701772
	self:ForceOver(SkillEffect[11000701772], caster, self.card, data, 1)
end
