-- 天赋效果305705
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305705 = oo.class(SkillBase)
function Skill305705:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill305705:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 305705
	if self:Rand(5000) then
		self:AddBuff(SkillEffect[305705], caster, self.card, data, 6104,1)
	end
end
