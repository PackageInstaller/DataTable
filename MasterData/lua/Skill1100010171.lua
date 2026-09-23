-- 对血量低于40%的单位伤害加深10%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010171 = oo.class(SkillBase)
function Skill1100010171:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100010171:OnBefourHurt(caster, target, data)
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
	-- 8098
	if SkillJudger:TargetPercentHp(self, caster, target, false,0.4) then
	else
		return
	end
	-- 1100010171
	self:AddTempAttr(SkillEffect[1100010171], caster, self.card, data, "damage",0.1)
end
