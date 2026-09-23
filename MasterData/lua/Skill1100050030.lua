-- 肉鸽虫洞阵营同调角色不再虚弱，同调角色后伤害提高30%，使用大招技能血量减少40%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100050030 = oo.class(SkillBase)
function Skill1100050030:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100050030:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9732
	if SkillJudger:IsCasterSibling(self, caster, target, true,30481) then
	else
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 9733
		if SkillJudger:IsCasterSibling(self, caster, target, true,30431) then
		else
			-- 8060
			if SkillJudger:CasterIsSelf(self, caster, target, true) then
			else
				return
			end
			-- 9734
			if SkillJudger:IsCasterSibling(self, caster, target, true,50041) then
			else
				-- 8060
				if SkillJudger:CasterIsSelf(self, caster, target, true) then
				else
					return
				end
				-- 9735
				if SkillJudger:IsCasterSibling(self, caster, target, true,50011) then
				else
					return
				end
			end
		end
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 1100030010
	self:AddTempAttr(SkillEffect[1100030010], caster, caster, data, "damage",0.3)
end
-- 行动结束
function Skill1100050030:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 1100030013
	self:AddHp(SkillEffect[1100030013], caster, caster, data, -count20*0.4)
end
-- 入场时
function Skill1100050030:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100030016
	self:AddBuff(SkillEffect[1100030016], caster, self.card, data, 1100030016)
end
