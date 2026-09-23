-- 6.1新天启buff34
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6400040 = oo.class(SkillBase)
function Skill6400040:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill6400040:OnBefourHurt(caster, target, data)
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
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 1100070206
	if SkillJudger:IsBeatBack(self, caster, target, false) then
	else
		return
	end
	-- 6400034
	self:AddTempAttr(SkillEffect[6400034], caster, caster, data, "damage2",-0.1)
end
