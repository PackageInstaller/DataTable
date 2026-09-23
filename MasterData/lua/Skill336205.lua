-- 灼碧4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill336205 = oo.class(SkillBase)
function Skill336205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill336205:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 336205
	self:AddBuff(SkillEffect[336205], caster, self.card, data, 336205)
end
