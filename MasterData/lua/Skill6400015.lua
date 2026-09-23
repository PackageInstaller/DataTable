-- 6.1新天启buff15
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6400015 = oo.class(SkillBase)
function Skill6400015:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill6400015:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100070123
	self:AddBuff(SkillEffect[1100070123], caster, self.card, data, 1100070123,3)
end
