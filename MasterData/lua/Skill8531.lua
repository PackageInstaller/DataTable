-- 天赋效果31
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8531 = oo.class(SkillBase)
function Skill8531:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill8531:OnRoundBegin(caster, target, data)
	-- 8531
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
		-- 70014
		if self:Rand(4000) then
			self:AddNp(SkillEffect[70014], caster, self.card, data, 10)
		end
	end
end
