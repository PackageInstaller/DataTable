-- 6.1新天启buff29
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6400029 = oo.class(SkillBase)
function Skill6400029:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill6400029:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 5500107
	self:AddBuff(SkillEffect[5500107], caster, self.card, data, 5500107)
end
