-- 天赋效果300503
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill300503 = oo.class(SkillBase)
function Skill300503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill300503:OnBefourHurt(caster, target, data)
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
	-- 8405
	local count5 = SkillApi:PercentHp(self, caster, target,1)
	-- 300503
	self:AddTempAttr(SkillEffect[300503], caster, self.card, data, "damage",math.min((1-count5)*0.3,0.3))
end
