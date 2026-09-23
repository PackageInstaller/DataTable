-- 辅助者
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill315004 = oo.class(SkillBase)
function Skill315004:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 治疗时
function Skill315004:OnCure(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 315004
	self:AddBuff(SkillEffect[315004], caster, target, data, 2604)
end
