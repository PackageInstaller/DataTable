-- 天赋效果311601
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill311601 = oo.class(SkillBase)
function Skill311601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill311601:OnBefourHurt(caster, target, data)
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
	-- 311601
	self:LimitDamage(SkillEffect[311601], caster, target, data, 0.02,0.24)
end
