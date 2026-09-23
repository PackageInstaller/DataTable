-- 天赋效果30
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8530 = oo.class(SkillBase)
function Skill8530:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill8530:OnRoundBegin(caster, target, data)
	-- 8530
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
		-- 70013
		if self:Rand(3500) then
			self:AddNp(SkillEffect[70013], caster, self.card, data, 10)
		end
	end
end
