-- 共用血条机制挑战2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070076 = oo.class(SkillBase)
function Skill1100070076:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 战斗开始
function Skill1100070076:OnStart(caster, target, data)
	-- 11000700760
	self:SetInvincible(SkillEffect[11000700760], caster, target, data, 4,1,726519,999)
end
-- 攻击结束
function Skill1100070076:OnAttackOver(caster, target, data)
	-- 912100002
	local angler2 = SkillApi:GetStateDamage(self, caster, self.card,nil)
	-- 11000700765
	if SkillJudger:GreaterEqual(self, caster, target, true,angler2,726519) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 11000700762
	self:ForceOver(SkillEffect[11000700762], caster, self.card, data, 1)
end
-- 回合开始时
function Skill1100070076:OnRoundBegin(caster, target, data)
	-- 912100002
	local angler2 = SkillApi:GetStateDamage(self, caster, self.card,nil)
	-- 11000700765
	if SkillJudger:GreaterEqual(self, caster, target, true,angler2,726519) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 11000700762
	self:ForceOver(SkillEffect[11000700762], caster, self.card, data, 1)
end
