-- 协奏曲
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill201400203 = oo.class(SkillBase)
function Skill201400203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill201400203:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 201400203
	if self:Rand(4000) then
		self:AddBuff(SkillEffect[201400203], caster, self.card, data, 201400201)
	end
end
