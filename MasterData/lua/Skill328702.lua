-- 纳格陵天赋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill328702 = oo.class(SkillBase)
function Skill328702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill328702:OnBefourHurt(caster, target, data)
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
	-- 328702
	if SkillJudger:TargetPercentHp(self, caster, target, true,0.5) then
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
		-- 8411
		local count11 = SkillApi:BuffCount(self, caster, target,1,1,2)
		-- 328712
		self:AddTempAttrPercent(SkillEffect[328712], caster, target, data, "defense",-0.15)
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
		-- 8411
		local count11 = SkillApi:BuffCount(self, caster, target,1,1,2)
		-- 328722
		self:AddTempAttr(SkillEffect[328722], caster, self.card, data, "damage",0.15)
	end
end
