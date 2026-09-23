-- 莉普丝2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill332705 = oo.class(SkillBase)
function Skill332705:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 暴击伤害前(OnBefourHurt之前)
function Skill332705:OnBefourCritHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 332705
	self:AddTempAttr(SkillEffect[332705], caster, caster, data, "crit_rate",-0.5)
end
