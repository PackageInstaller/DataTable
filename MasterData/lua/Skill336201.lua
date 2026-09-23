-- 灼碧4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill336201 = oo.class(SkillBase)
function Skill336201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill336201:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 336201
	self:AddBuff(SkillEffect[336201], caster, self.card, data, 336201)
end
