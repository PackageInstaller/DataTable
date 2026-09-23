-- 同调角色不再虚弱，同调角色后伤害提高80%，使用大招技能血量减少10%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100030012 = oo.class(SkillBase)
function Skill1100030012:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100030012:OnBefourHurt(caster, target, data)
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
	-- 1100030012
	self:AddTempAttr(SkillEffect[1100030012], caster, caster, data, "damage",0.8)
end
-- 行动结束
function Skill1100030012:OnActionOver(caster, target, data)
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
	-- 1100030015
	self:AddHp(SkillEffect[1100030015], caster, caster, data, -count20*0.1)
end
-- 入场时
function Skill1100030012:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100030016
	self:AddBuff(SkillEffect[1100030016], caster, self.card, data, 1100030016)
end
