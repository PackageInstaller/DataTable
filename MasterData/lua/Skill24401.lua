-- 连击I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill24401 = oo.class(SkillBase)
function Skill24401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill24401:OnActionOver(caster, target, data)
	-- 24401
	self:tFunc_24401_24411(caster, target, data)
	self:tFunc_24401_24421(caster, target, data)
	self:tFunc_24401_24431(caster, target, data)
end
function Skill24401:tFunc_24401_24431(caster, target, data)
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
	-- 24431
	self:AddBuff(SkillEffect[24431], caster, self.card, data, 24401)
end
function Skill24401:tFunc_24401_24421(caster, target, data)
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
	-- 24421
	self:AddBuff(SkillEffect[24421], caster, self.card, data, 24401)
end
function Skill24401:tFunc_24401_24411(caster, target, data)
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
	-- 24411
	self:AddBuff(SkillEffect[24411], caster, self.card, data, 24401)
end
