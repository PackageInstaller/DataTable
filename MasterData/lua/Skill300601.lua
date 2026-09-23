-- 天赋效果300601
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill300601 = oo.class(SkillBase)
function Skill300601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill300601:OnBefourHurt(caster, target, data)
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
	-- 8406
	local count6 = SkillApi:PercentHp(self, caster, target,2)
	-- 300601
	self:AddTempAttr(SkillEffect[300601], caster, self.card, data, "damage",math.min((1-count6)*0.1,0.1))
end
