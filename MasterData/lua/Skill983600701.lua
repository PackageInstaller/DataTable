-- 引力神光
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill983600701 = oo.class(SkillBase)
function Skill983600701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill983600701:OnBorn(caster, target, data)
	-- 110008032
	self:CallSkill(SkillEffect[110008032], caster, self.card, data, 983600201)
end
