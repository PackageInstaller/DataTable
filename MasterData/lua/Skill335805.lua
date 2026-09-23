-- 朝晖4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill335805 = oo.class(SkillBase)
function Skill335805:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill335805:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8710
	local count710 = SkillApi:SkillLevel(self, caster, target,3,7044001)
	-- 8709
	local count709 = SkillApi:GetCount(self, caster, target,3,704400101)
	-- 8922
	if SkillJudger:Greater(self, caster, target, true,count709,5) then
	else
		return
	end
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 335805
	if self:Rand(5000) then
		self:CallOwnerSkill(SkillEffect[335805], caster, target, data, 704400100+count710)
	end
end
