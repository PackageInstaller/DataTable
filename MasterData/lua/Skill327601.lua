-- 极速抵御
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill327601 = oo.class(SkillBase)
function Skill327601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill327601:OnActionOver(caster, target, data)
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
	-- 327601
	self:AddBuff(SkillEffect[327601], caster, self.card, data, 327601)
end
