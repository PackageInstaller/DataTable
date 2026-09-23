-- 天赋效果27
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8527 = oo.class(SkillBase)
function Skill8527:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill8527:OnBorn(caster, target, data)
	-- 8527
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
		-- 70010
		self:AddNp(SkillEffect[70010], caster, self.card, data, 10)
	end
end
