-- 6.1新天启buff1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6400001 = oo.class(SkillBase)
function Skill6400001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill6400001:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 6400012
	self:OwnerAddBuff(SkillEffect[6400012], caster, self.card, data, 6400012)
end
