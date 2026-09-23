-- 6.1新天启buff26
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6400026 = oo.class(SkillBase)
function Skill6400026:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill6400026:OnBefourHurt(caster, target, data)
	-- 6400028
	self:tFunc_6400028_6400026(caster, target, data)
	self:tFunc_6400028_6400027(caster, target, data)
end
function Skill6400026:tFunc_6400028_6400027(caster, target, data)
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 8099
	if SkillJudger:TargetPercentHp(self, caster, target, false,0.3) then
	else
		return
	end
	-- 6400027
	self:AddTempAttr(SkillEffect[6400027], caster, caster, data, "damage",0.2)
end
function Skill6400026:tFunc_6400028_6400026(caster, target, data)
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 6400026
	self:AddTempAttr(SkillEffect[6400026], caster, caster, data, "damage",0.2)
end
