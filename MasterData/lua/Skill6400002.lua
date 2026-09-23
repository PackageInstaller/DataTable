-- 6.1新天启buff2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6400002 = oo.class(SkillBase)
function Skill6400002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill6400002:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 6400013
	self:OwnerAddBuff(SkillEffect[6400013], caster, self.card, data, 6400013)
end
