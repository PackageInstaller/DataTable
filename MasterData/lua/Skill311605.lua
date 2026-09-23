-- 天赋效果311605
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill311605 = oo.class(SkillBase)
function Skill311605:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill311605:OnBefourHurt(caster, target, data)
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
	-- 8441
	local count41 = SkillApi:BuffCount(self, caster, target,2,1,15)
	-- 8124
	if SkillJudger:Greater(self, caster, self.card, true,count41,0) then
	else
		return
	end
	-- 311605
	self:LimitDamage(SkillEffect[311605], caster, target, data, 0.06,0.72)
end
