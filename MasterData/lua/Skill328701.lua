-- 纳格陵天赋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill328701 = oo.class(SkillBase)
function Skill328701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill328701:OnBefourHurt(caster, target, data)
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
	-- 328701
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
		-- 328711
		self:AddTempAttrPercent(SkillEffect[328711], caster, target, data, "defense",-0.10)
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
		-- 328721
		self:AddTempAttr(SkillEffect[328721], caster, self.card, data, "damage",0.10)
	end
end
