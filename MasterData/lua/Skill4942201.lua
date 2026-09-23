-- 熔铄被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4942201 = oo.class(SkillBase)
function Skill4942201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4942201:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4704206
	self:OwnerAddBuff(SkillEffect[4704206], caster, self.card, data, 1081)
end
-- 行动结束
function Skill4942201:OnActionOver(caster, target, data)
	-- 4704221
	self:tFunc_4704221_4704201(caster, target, data)
	self:tFunc_4704221_4704211(caster, target, data)
end
-- 伤害前
function Skill4942201:OnBefourHurt(caster, target, data)
	-- 4704231
	self:AddTempAttr(SkillEffect[4704231], caster, self.card, data, "damage",0.10)
end
function Skill4942201:tFunc_4704221_4704201(caster, target, data)
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
	-- 4704201
	self:OwnerAddBuff(SkillEffect[4704201], caster, target, data, 1082)
end
function Skill4942201:tFunc_4704221_4704211(caster, target, data)
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
	-- 4704211
	self:OwnerAddBuff(SkillEffect[4704211], caster, target, data, 1087)
end
