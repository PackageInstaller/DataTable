-- 钓鱼佬
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill912101101 = oo.class(SkillBase)
function Skill912101101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill912101101:OnAttackOver(caster, target, data)
	-- 912100002
	local angler2 = SkillApi:GetStateDamage(self, caster, self.card,nil)
	-- 912102203
	if SkillJudger:GreaterEqual(self, caster, target, true,angler2,300000) then
	else
		return
	end
	-- 912102211
	if SkillJudger:HasBuff(self, caster, target, true,3,912102210) then
	else
		return
	end
	-- 912101103
	self:CallSkill(SkillEffect[912101103], caster, target, data, 912100411)
end
-- 行动结束2
function Skill912101101:OnActionOver2(caster, target, data)
	-- 912100001
	local angler1 = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 912102201
	if SkillJudger:GreaterEqual(self, caster, target, true,angler1,10) then
	else
		return
	end
	-- 912102211
	if SkillJudger:HasBuff(self, caster, target, true,3,912102210) then
	else
		return
	end
	-- 912101104
	local r = self.card:Rand(2)+1
	if 1 == r then
		-- 912100001
		local angler1 = SkillApi:GetTurnCount(self, caster, self.card,nil)
		-- 912102201
		if SkillJudger:GreaterEqual(self, caster, target, true,angler1,10) then
		else
			return
		end
		-- 912102211
		if SkillJudger:HasBuff(self, caster, target, true,3,912102210) then
		else
			return
		end
		-- 912101101
		self:CallSkill(SkillEffect[912101101], caster, target, data, 912100301)
	elseif 2 == r then
		-- 912100001
		local angler1 = SkillApi:GetTurnCount(self, caster, self.card,nil)
		-- 912102201
		if SkillJudger:GreaterEqual(self, caster, target, true,angler1,10) then
		else
			return
		end
		-- 912102211
		if SkillJudger:HasBuff(self, caster, target, true,3,912102210) then
		else
			return
		end
		-- 912101102
		self:CallSkill(SkillEffect[912101102], caster, target, data, 912100401)
	end
end
-- 行动开始
function Skill912101101:OnActionBegin(caster, target, data)
	-- 8468
	local count68 = SkillApi:GetAttr(self, caster, target,2,"maxhp")
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 912102211
	if SkillJudger:HasBuff(self, caster, target, true,3,912102210) then
	else
		return
	end
	-- 912102121
	local targets = SkillFilter:Teammate(self, caster, target, 1)
	for i,target in ipairs(targets) do
		self:AddHp(SkillEffect[912102121], caster, target, data, -count68)
	end
end
