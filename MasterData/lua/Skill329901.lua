-- 赤髓天赋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill329901 = oo.class(SkillBase)
function Skill329901:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill329901:OnBefourHurt(caster, target, data)
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
	-- 8423
	local count23 = SkillApi:GetAttr(self, caster, target,3,"defense")
	-- 329901
	self:AddTempAttr(SkillEffect[329901], caster, self.card, data, "attack",count23*0.3)
	-- 8428
	local count28 = SkillApi:BuffCount(self, caster, target,2,3,1002)
	-- 8111
	if SkillJudger:Greater(self, caster, self.card, true,count28,0) then
	else
		return
	end
	-- 329911
	self:AddTempAttr(SkillEffect[329911], caster, self.card, data, "damage",0.1)
end
