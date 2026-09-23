-- 天赋效果311502
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill311502 = oo.class(SkillBase)
function Skill311502:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill311502:OnBefourHurt(caster, target, data)
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
	-- 8440
	local count40 = SkillApi:BuffCount(self, caster, target,2,1,14)
	-- 8123
	if SkillJudger:Greater(self, caster, self.card, true,count40,0) then
	else
		return
	end
	-- 311502
	self:LimitDamage(SkillEffect[311502], caster, target, data, 0.03,0.36)
end
