-- 乘适行进
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill318902 = oo.class(SkillBase)
function Skill318902:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill318902:OnAfterHurt(caster, target, data)
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
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 318902
	self:AddProgress(SkillEffect[318902], caster, self.card, data, 40)
end
