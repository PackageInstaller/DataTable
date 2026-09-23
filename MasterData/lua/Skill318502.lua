-- 治疗强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill318502 = oo.class(SkillBase)
function Skill318502:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill318502:OnActionBegin(caster, target, data)
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
	-- 318502
	self:AddBuff(SkillEffect[318502], caster, self.card, data, 3302)
end
-- 行动结束
function Skill318502:OnActionOver(caster, target, data)
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
	-- 318511
	self:AddBuff(SkillEffect[318511], caster, target, data, 6103,1)
end
