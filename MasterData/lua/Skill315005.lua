-- 辅助者
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill315005 = oo.class(SkillBase)
function Skill315005:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 治疗时
function Skill315005:OnCure(caster, target, data)
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
	-- 315005
	self:AddBuff(SkillEffect[315005], caster, target, data, 2605)
end
