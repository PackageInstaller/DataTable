-- 天赋效果309304
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill309304 = oo.class(SkillBase)
function Skill309304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill309304:OnBefourHurt(caster, target, data)
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
	-- 8436
	local count36 = SkillApi:BuffCount(self, caster, target,2,3,3007)
	-- 8119
	if SkillJudger:Greater(self, caster, self.card, true,count36,0) then
	else
		return
	end
	-- 309304
	self:AddTempAttr(SkillEffect[309304], caster, caster, data, "damage",0.12)
end
