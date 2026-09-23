-- 钓鱼佬
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill912101201 = oo.class(SkillBase)
function Skill912101201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill912101201:OnAttackOver(caster, target, data)
	-- 912100002
	local angler2 = SkillApi:GetStateDamage(self, caster, self.card,nil)
	-- 912102303
	if SkillJudger:GreaterEqual(self, caster, target, true,angler2,600000) then
	else
		return
	end
	-- 912102311
	if SkillJudger:HasBuff(self, caster, target, true,3,912102310) then
	else
		return
	end
	-- 912101203
	self:CallSkill(SkillEffect[912101203], caster, target, data, 912100611)
end
-- 行动结束2
function Skill912101201:OnActionOver2(caster, target, data)
	-- 912100001
	local angler1 = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 912102301
	if SkillJudger:GreaterEqual(self, caster, target, true,angler1,12) then
	else
		return
	end
	-- 912102311
	if SkillJudger:HasBuff(self, caster, target, true,3,912102310) then
	else
		return
	end
	-- 912101204
	local r = self.card:Rand(2)+1
	if 1 == r then
		-- 912100001
		local angler1 = SkillApi:GetTurnCount(self, caster, self.card,nil)
		-- 912102301
		if SkillJudger:GreaterEqual(self, caster, target, true,angler1,12) then
		else
			return
		end
		-- 912102311
		if SkillJudger:HasBuff(self, caster, target, true,3,912102310) then
		else
			return
		end
		-- 912101201
		self:CallSkill(SkillEffect[912101201], caster, target, data, 912100501)
	elseif 2 == r then
		-- 912100001
		local angler1 = SkillApi:GetTurnCount(self, caster, self.card,nil)
		-- 912102301
		if SkillJudger:GreaterEqual(self, caster, target, true,angler1,12) then
		else
			return
		end
		-- 912102311
		if SkillJudger:HasBuff(self, caster, target, true,3,912102310) then
		else
			return
		end
		-- 912101202
		self:CallSkill(SkillEffect[912101202], caster, target, data, 912100601)
	end
end
-- 行动开始
function Skill912101201:OnActionBegin(caster, target, data)
	-- 8468
	local count68 = SkillApi:GetAttr(self, caster, target,2,"maxhp")
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 912102311
	if SkillJudger:HasBuff(self, caster, target, true,3,912102310) then
	else
		return
	end
	-- 912102221
	local targets = SkillFilter:Teammate(self, caster, target, 1)
	for i,target in ipairs(targets) do
		self:AddHp(SkillEffect[912102221], caster, target, data, -count68)
	end
end
