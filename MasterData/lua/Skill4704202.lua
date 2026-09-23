-- 熔铄被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4704202 = oo.class(SkillBase)
function Skill4704202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4704202:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4704206
	self:OwnerAddBuff(SkillEffect[4704206], caster, self.card, data, 1081)
end
-- 行动结束
function Skill4704202:OnActionOver(caster, target, data)
	-- 4704222
	self:tFunc_4704222_4704202(caster, target, data)
	self:tFunc_4704222_4704212(caster, target, data)
end
-- 伤害前
function Skill4704202:OnBefourHurt(caster, target, data)
	-- 4704232
	self:AddTempAttr(SkillEffect[4704232], caster, self.card, data, "damage",0.15)
end
function Skill4704202:tFunc_4704222_4704212(caster, target, data)
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
	-- 4704212
	self:OwnerAddBuff(SkillEffect[4704212], caster, target, data, 1088)
end
function Skill4704202:tFunc_4704222_4704202(caster, target, data)
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
	-- 4704202
	self:OwnerAddBuff(SkillEffect[4704202], caster, target, data, 1083)
end
