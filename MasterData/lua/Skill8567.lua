-- 天赋效果67
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8567 = oo.class(SkillBase)
function Skill8567:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill8567:OnRoundBegin(caster, target, data)
	-- 8567
	self:SummonRevive(SkillEffect[8567], caster, target, data, nil)
end
