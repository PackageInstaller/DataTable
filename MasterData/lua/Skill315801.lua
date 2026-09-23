-- 能量穿透
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill315801 = oo.class(SkillBase)
function Skill315801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill315801:OnBefourHurt(caster, target, data)
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
	-- 8127
	if SkillJudger:IsTargetCareer(self, caster, target, true,2) then
	else
		return
	end
	-- 315801
	self:AddTempAttr(SkillEffect[315801], caster, self.card, data, "damage",0.06)
end
