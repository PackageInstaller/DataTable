-- 天赋效果309504
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill309504 = oo.class(SkillBase)
function Skill309504:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill309504:OnBefourHurt(caster, target, data)
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
	-- 8438
	local count38 = SkillApi:BuffCount(self, caster, target,2,3,3009)
	-- 8121
	if SkillJudger:Greater(self, caster, self.card, true,count38,0) then
	else
		return
	end
	-- 309504
	self:AddTempAttr(SkillEffect[309504], caster, caster, data, "damage",0.12)
end
