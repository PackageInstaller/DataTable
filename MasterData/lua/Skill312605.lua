-- 天赋效果312605
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill312605 = oo.class(SkillBase)
function Skill312605:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill312605:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 312605
	self:FlyAdjust(SkillEffect[312605], caster, self.card, data, 1.24,10000)
end
