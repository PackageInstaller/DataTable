-- 熔铄被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4942204 = oo.class(SkillBase)
function Skill4942204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4942204:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4704206
	self:OwnerAddBuff(SkillEffect[4704206], caster, self.card, data, 1081)
end
-- 行动结束
function Skill4942204:OnActionOver(caster, target, data)
	-- 4704224
	self:tFunc_4704224_4704204(caster, target, data)
	self:tFunc_4704224_4704214(caster, target, data)
end
-- 伤害前
function Skill4942204:OnBefourHurt(caster, target, data)
	-- 4704234
	self:AddTempAttr(SkillEffect[4704234], caster, self.card, data, "damage",0.25)
end
function Skill4942204:tFunc_4704224_4704214(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9731
	if SkillJudger:IsTypeOf(self, caster, target, true,4) then
	else
		return
	end
	-- 4704214
	self:OwnerAddBuff(SkillEffect[4704214], caster, target, data, 1090)
end
function Skill4942204:tFunc_4704224_4704204(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8215
	if SkillJudger:IsTypeOf(self, caster, target, true,3) then
	else
		return
	end
	-- 4704204
	self:OwnerAddBuff(SkillEffect[4704204], caster, target, data, 1085)
end
