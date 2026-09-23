-- 天赋效果300805
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill300805 = oo.class(SkillBase)
function Skill300805:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill300805:OnBefourHurt(caster, target, data)
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
	-- 8409
	local count9 = SkillApi:BuffCount(self, caster, target,1,1,3)
	-- 300805
	self:AddTempAttr(SkillEffect[300805], caster, self.card, data, "damage",count9*0.12)
end
