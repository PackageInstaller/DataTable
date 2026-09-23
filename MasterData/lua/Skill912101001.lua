-- 钓鱼佬
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill912101001 = oo.class(SkillBase)
function Skill912101001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 战斗开始
function Skill912101001:OnStart(caster, target, data)
	-- 912102100
	self:SetInvincible(SkillEffect[912102100], caster, target, data, 4,1,80000,10)
end
-- 入场时
function Skill912101001:OnBorn(caster, target, data)
	-- 912102110
	self:AddBuff(SkillEffect[912102110], caster, self.card, data, 912102110)
end
-- 攻击结束
function Skill912101001:OnAttackOver(caster, target, data)
	-- 912100002
	local angler2 = SkillApi:GetStateDamage(self, caster, self.card,nil)
	-- 912102103
	if SkillJudger:GreaterEqual(self, caster, target, true,angler2,80000) then
	else
		return
	end
	-- 912102111
	if SkillJudger:HasBuff(self, caster, target, true,3,912102110) then
	else
		return
	end
	-- 912101003
	self:CallSkill(SkillEffect[912101003], caster, target, data, 912100211)
end
-- 行动结束2
function Skill912101001:OnActionOver2(caster, target, data)
	-- 912100001
	local angler1 = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 912102101
	if SkillJudger:GreaterEqual(self, caster, target, true,angler1,10) then
	else
		return
	end
	-- 912102111
	if SkillJudger:HasBuff(self, caster, target, true,3,912102110) then
	else
		return
	end
	-- 912101004
	local r = self.card:Rand(2)+1
	if 1 == r then
		-- 912100001
		local angler1 = SkillApi:GetTurnCount(self, caster, self.card,nil)
		-- 912102101
		if SkillJudger:GreaterEqual(self, caster, target, true,angler1,10) then
		else
			return
		end
		-- 912102111
		if SkillJudger:HasBuff(self, caster, target, true,3,912102110) then
		else
			return
		end
		-- 912101001
		self:CallSkill(SkillEffect[912101001], caster, target, data, 912100201)
	elseif 2 == r then
		-- 912100001
		local angler1 = SkillApi:GetTurnCount(self, caster, self.card,nil)
		-- 912102101
		if SkillJudger:GreaterEqual(self, caster, target, true,angler1,10) then
		else
			return
		end
		-- 912102111
		if SkillJudger:HasBuff(self, caster, target, true,3,912102110) then
		else
			return
		end
		-- 912101002
		self:CallSkill(SkillEffect[912101002], caster, target, data, 912100101)
	end
end
