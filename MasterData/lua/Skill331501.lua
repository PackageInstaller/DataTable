-- 努特2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill331501 = oo.class(SkillBase)
function Skill331501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill331501:OnBefourHurt(caster, target, data)
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
	-- 8431
	local count31 = SkillApi:BuffCount(self, caster, target,2,4,3002)
	-- 8114
	if SkillJudger:Greater(self, caster, self.card, true,count31,0) then
	else
		return
	end
	-- 331501
	self:AddTempAttr(SkillEffect[331501], caster, self.card, data, "damage",0.10)
end
