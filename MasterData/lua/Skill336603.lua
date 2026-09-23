-- 伏特加·镜4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill336603 = oo.class(SkillBase)
function Skill336603:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 暴击伤害前(OnBefourHurt之前)
function Skill336603:OnBefourCritHurt(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
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
	-- 336603
	self:AddTempAttr(SkillEffect[336603], caster, caster, data, "crit",0.09)
end
