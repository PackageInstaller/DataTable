-- 天赋效果305901
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305901 = oo.class(SkillBase)
function Skill305901:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill305901:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 305901
	if self:Rand(1000) then
		self:AddBuff(SkillEffect[305901], caster, self.card, data, 6107,1)
	end
end
