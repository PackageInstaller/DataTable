-- 机神共鸣
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill315504 = oo.class(SkillBase)
function Skill315504:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill315504:OnRoundBegin(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 315504
	self:AddSp(SkillEffect[315504], caster, caster, data, 20)
end
