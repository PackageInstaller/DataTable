-- 机神共鸣
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill315502 = oo.class(SkillBase)
function Skill315502:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill315502:OnRoundBegin(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 315502
	self:AddSp(SkillEffect[315502], caster, caster, data, 10)
end
