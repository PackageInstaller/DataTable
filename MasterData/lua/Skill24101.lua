-- 破军I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill24101 = oo.class(SkillBase)
function Skill24101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill24101:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 24101
	self:AddBuff(SkillEffect[24101], caster, self.card, data, 24101)
end
