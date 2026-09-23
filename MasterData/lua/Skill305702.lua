-- 天赋效果305702
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305702 = oo.class(SkillBase)
function Skill305702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill305702:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 305702
	if self:Rand(2000) then
		self:AddBuff(SkillEffect[305702], caster, self.card, data, 6104,1)
	end
end
