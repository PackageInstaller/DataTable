-- 天赋效果62
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8562 = oo.class(SkillBase)
function Skill8562:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill8562:OnAttackOver(caster, target, data)
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
	-- 8201
	if SkillJudger:IsSingle(self, caster, target, true) then
	else
		return
	end
	-- 8562
	local r = self.card:Rand(4)+1
	if 1 == r then
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
		-- 8201
		if SkillJudger:IsSingle(self, caster, target, true) then
		else
			return
		end
		-- 8458
		local count58 = SkillApi:GetAttr(self, caster, target,2,"attack")
		-- 8317
		self:AddValue(SkillEffect[8317], caster, self.card, data, "gj1",count58)
		-- 8558
		self:RelevanceBuff(SkillEffect[8558], caster, target, data, 8501,8511)
		-- 8318
		self:DelValue(SkillEffect[8318], caster, self.card, data, "gj1")
	elseif 2 == r then
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
		-- 8201
		if SkillJudger:IsSingle(self, caster, target, true) then
		else
			return
		end
		-- 8459
		local count59 = SkillApi:GetAttr(self, caster, target,2,"defense")
		-- 8319
		self:AddValue(SkillEffect[8319], caster, self.card, data, "fy1",count59)
		-- 8559
		self:RelevanceBuff(SkillEffect[8559], caster, target, data, 8502,8512)
		-- 8320
		self:DelValue(SkillEffect[8320], caster, self.card, data, "fy1")
	elseif 3 == r then
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
		-- 8201
		if SkillJudger:IsSingle(self, caster, target, true) then
		else
			return
		end
		-- 8460
		local count60 = SkillApi:GetAttr(self, caster, target,2,"crit_rate")
		-- 8321
		self:AddValue(SkillEffect[8321], caster, self.card, data, "bj1",count60)
		-- 8560
		self:RelevanceBuff(SkillEffect[8560], caster, target, data, 8503,8513)
		-- 8322
		self:DelValue(SkillEffect[8322], caster, self.card, data, "bj1")
	elseif 4 == r then
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
		-- 8201
		if SkillJudger:IsSingle(self, caster, target, true) then
		else
			return
		end
		-- 8461
		local count61 = SkillApi:GetAttr(self, caster, target,2,"speed")
		-- 8323
		self:AddValue(SkillEffect[8323], caster, self.card, data, "sd1",count61)
		-- 8561
		self:RelevanceBuff(SkillEffect[8561], caster, target, data, 8504,8514)
		-- 8324
		self:DelValue(SkillEffect[8324], caster, self.card, data, "sd1")
	end
end
