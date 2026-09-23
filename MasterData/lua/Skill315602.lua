-- 高能核心
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill315602 = oo.class(SkillBase)
function Skill315602:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill315602:OnActionBegin(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 315602
	self:AddBuff(SkillEffect[315602], caster, caster, data, 4003,1)
end
