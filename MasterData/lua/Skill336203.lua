-- 灼碧4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill336203 = oo.class(SkillBase)
function Skill336203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill336203:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 336203
	self:AddBuff(SkillEffect[336203], caster, self.card, data, 336203)
end
