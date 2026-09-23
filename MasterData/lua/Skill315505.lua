-- 机神共鸣
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill315505 = oo.class(SkillBase)
function Skill315505:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill315505:OnRoundBegin(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 315505
	self:AddSp(SkillEffect[315505], caster, caster, data, 25)
end
