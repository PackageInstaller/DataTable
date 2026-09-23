-- 天赋效果309102
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill309102 = oo.class(SkillBase)
function Skill309102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill309102:OnBefourHurt(caster, target, data)
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
	-- 8434
	local count34 = SkillApi:BuffCount(self, caster, target,2,3,3005)
	-- 8117
	if SkillJudger:Greater(self, caster, self.card, true,count34,0) then
	else
		return
	end
	-- 309102
	self:AddTempAttr(SkillEffect[309102], caster, caster, data, "damage",0.08)
end
