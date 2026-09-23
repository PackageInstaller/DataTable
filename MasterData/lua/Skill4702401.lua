-- 极寒
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4702401 = oo.class(SkillBase)
function Skill4702401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4702401:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8434
	local count34 = SkillApi:BuffCount(self, caster, target,2,3,3005)
	-- 8117
	if SkillJudger:Greater(self, caster, self.card, true,count34,0) then
	else
		return
	end
	-- 4702404
	self:AddTempAttr(SkillEffect[4702404], caster, self.card, data, "damage",0.2)
end
-- 伤害后
function Skill4702401:OnAfterHurt(caster, target, data)
	-- 8649
	local count649 = SkillApi:SkillLevel(self, caster, target,3,3291)
	-- 4702417
	if SkillJudger:Less(self, caster, target, true,count649,1) then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 8073
		if SkillJudger:TargetIsEnemy(self, caster, target, true) then
		else
			return
		end
		-- 4702401
		self:HitAddBuff(SkillEffect[4702401], caster, target, data, 600,3005)
	else
		-- 8649
		local count649 = SkillApi:SkillLevel(self, caster, target,3,3291)
		-- 8853
		if SkillJudger:Greater(self, caster, target, true,count649,0) then
		else
			return
		end
		-- 8650
		local count650 = SkillApi:GetAttr(self, caster, target,2,"resist")
		-- 4702414
		if SkillJudger:Less(self, caster, target, true,count650,0.3) then
			-- 8060
			if SkillJudger:CasterIsSelf(self, caster, target, true) then
			else
				return
			end
			-- 8073
			if SkillJudger:TargetIsEnemy(self, caster, target, true) then
			else
				return
			end
			-- 4702411
			self:HitAddBuff(SkillEffect[4702411], caster, target, data, 600+count649*100,3005)
		else
			-- 8060
			if SkillJudger:CasterIsSelf(self, caster, target, true) then
			else
				return
			end
			-- 8073
			if SkillJudger:TargetIsEnemy(self, caster, target, true) then
			else
				return
			end
			-- 4702401
			self:HitAddBuff(SkillEffect[4702401], caster, target, data, 600,3005)
		end
	end
end
