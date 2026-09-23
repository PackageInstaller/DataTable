-- 天赋效果32
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8532 = oo.class(SkillBase)
function Skill8532:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill8532:OnRoundBegin(caster, target, data)
	-- 8532
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
		-- 70015
		if self:Rand(5000) then
			self:AddNp(SkillEffect[70015], caster, self.card, data, 10)
		end
	end
end
