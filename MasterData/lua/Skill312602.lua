-- 天赋效果312602
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill312602 = oo.class(SkillBase)
function Skill312602:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill312602:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 312602
	self:FlyAdjust(SkillEffect[312602], caster, self.card, data, 1.12,10000)
end
