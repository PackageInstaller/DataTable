-- 连击III级（怪物使用）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill24404 = oo.class(SkillBase)
function Skill24404:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill24404:OnActionOver(caster, target, data)
	-- 24406
	self:tFunc_24406_24414(caster, target, data)
	self:tFunc_24406_24424(caster, target, data)
	self:tFunc_24406_24434(caster, target, data)
end
function Skill24404:tFunc_24406_24424(caster, target, data)
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
	-- 24424
	self:AddBuff(SkillEffect[24424], caster, self.card, data, 24404)
end
function Skill24404:tFunc_24406_24414(caster, target, data)
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
	-- 24414
	self:AddBuff(SkillEffect[24414], caster, self.card, data, 24404)
end
function Skill24404:tFunc_24406_24434(caster, target, data)
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
	-- 24434
	self:AddBuff(SkillEffect[24434], caster, self.card, data, 24404)
end
