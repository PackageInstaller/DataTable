-- 灼碧4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill336204 = oo.class(SkillBase)
function Skill336204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill336204:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 336204
	self:AddBuff(SkillEffect[336204], caster, self.card, data, 336204)
end
