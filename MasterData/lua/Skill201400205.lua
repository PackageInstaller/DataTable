-- 协奏曲
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill201400205 = oo.class(SkillBase)
function Skill201400205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill201400205:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 201400205
	if self:Rand(5000) then
		self:AddBuff(SkillEffect[201400205], caster, self.card, data, 201400201)
	end
end
