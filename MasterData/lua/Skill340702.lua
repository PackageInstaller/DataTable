-- 乌鲁鲁2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill340702 = oo.class(SkillBase)
function Skill340702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill340702:OnActionBegin(caster, target, data)
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
	-- 8477
	local count77 = SkillApi:LiveCount(self, caster, target,4)
	-- 340702
	self:AddBuff(SkillEffect[340702], caster, self.card, data, 340710+math.min(count77,4))
end
