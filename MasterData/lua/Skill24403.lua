-- 连击III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill24403 = oo.class(SkillBase)
function Skill24403:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill24403:OnActionOver(caster, target, data)
	-- 24403
	self:tFunc_24403_24413(caster, target, data)
	self:tFunc_24403_24423(caster, target, data)
	self:tFunc_24403_24433(caster, target, data)
end
function Skill24403:tFunc_24403_24423(caster, target, data)
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
	-- 24423
	self:AddBuff(SkillEffect[24423], caster, self.card, data, 24403)
end
function Skill24403:tFunc_24403_24433(caster, target, data)
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
	-- 24433
	self:AddBuff(SkillEffect[24433], caster, self.card, data, 24403)
end
function Skill24403:tFunc_24403_24413(caster, target, data)
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
	-- 24413
	self:AddBuff(SkillEffect[24413], caster, self.card, data, 24403)
end
