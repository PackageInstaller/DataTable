-- 6.1新天启buff30
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6400030 = oo.class(SkillBase)
function Skill6400030:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill6400030:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 5500109
	self:AddBuff(SkillEffect[5500109], caster, self.card, data, 5500109)
end
