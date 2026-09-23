-- 纳格陵天赋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill328703 = oo.class(SkillBase)
function Skill328703:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill328703:OnBefourHurt(caster, target, data)
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
	-- 328703
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
		-- 328713
		self:AddTempAttrPercent(SkillEffect[328713], caster, target, data, "defense",-0.20)
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
		-- 328723
		self:AddTempAttr(SkillEffect[328723], caster, self.card, data, "damage",0.20)
	end
end
