-- 灼碧4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill336202 = oo.class(SkillBase)
function Skill336202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill336202:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 336202
	self:AddBuff(SkillEffect[336202], caster, self.card, data, 336202)
end
