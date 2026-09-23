-- 天赋效果1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8501 = oo.class(SkillBase)
function Skill8501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill8501:OnBefourHurt(caster, target, data)
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
	-- 8401
	local count1 = SkillApi:LiveCount(self, caster, target,1)
	-- 8501
	self:AddTempAttr(SkillEffect[8501], caster, self.card, data, "damage",count1*0.03)
end
