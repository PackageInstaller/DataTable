-- 天赋效果54
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8554 = oo.class(SkillBase)
function Skill8554:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill8554:OnBefourHurt(caster, target, data)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8422
	local count22 = SkillApi:BuffCount(self, caster, target,1,4,650)
	-- 8902
	if SkillJudger:Greater(self, caster, target, true,count22,0) then
	else
		return
	end
	-- 8554
	self:Cure(SkillEffect[8554], caster, self.card, data, 1,math.max(count22*0.08,0.08))
end
