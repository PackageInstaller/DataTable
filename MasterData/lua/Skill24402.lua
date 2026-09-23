-- 连击II级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill24402 = oo.class(SkillBase)
function Skill24402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill24402:OnActionOver(caster, target, data)
	-- 24402
	self:tFunc_24402_24412(caster, target, data)
	self:tFunc_24402_24422(caster, target, data)
	self:tFunc_24402_24432(caster, target, data)
end
function Skill24402:tFunc_24402_24422(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 24422
	self:AddBuff(SkillEffect[24422], caster, self.card, data, 24402)
end
function Skill24402:tFunc_24402_24432(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8260
	if SkillJudger:IsTypeOf(self, caster, target, true,5) then
	else
		return
	end
	-- 24432
	self:AddBuff(SkillEffect[24432], caster, self.card, data, 24402)
end
function Skill24402:tFunc_24402_24412(caster, target, data)
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
	-- 24412
	self:AddBuff(SkillEffect[24412], caster, self.card, data, 24402)
end
