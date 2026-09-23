-- 天赋效果29
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8529 = oo.class(SkillBase)
function Skill8529:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill8529:OnBorn(caster, target, data)
	-- 8529
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
		-- 70012
		self:AddNp(SkillEffect[70012], caster, self.card, data, 15)
	end
end
