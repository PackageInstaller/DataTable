-- 6.1新天启buff16
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6400016 = oo.class(SkillBase)
function Skill6400016:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill6400016:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100070124
	self:AddBuff(SkillEffect[1100070124], caster, self.card, data, 1100070124,3)
end
