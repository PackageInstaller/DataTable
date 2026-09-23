-- 熔铄被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4942205 = oo.class(SkillBase)
function Skill4942205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4942205:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4704206
	self:OwnerAddBuff(SkillEffect[4704206], caster, self.card, data, 1081)
end
-- 行动结束
function Skill4942205:OnActionOver(caster, target, data)
	-- 4704225
	self:tFunc_4704225_4704205(caster, target, data)
	self:tFunc_4704225_4704215(caster, target, data)
end
-- 伤害前
function Skill4942205:OnBefourHurt(caster, target, data)
	-- 4704235
	self:AddTempAttr(SkillEffect[4704235], caster, self.card, data, "damage",0.30)
end
function Skill4942205:tFunc_4704225_4704215(caster, target, data)
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
	-- 4704215
	self:OwnerAddBuff(SkillEffect[4704215], caster, target, data, 1091)
end
function Skill4942205:tFunc_4704225_4704205(caster, target, data)
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
	-- 4704205
	self:OwnerAddBuff(SkillEffect[4704205], caster, target, data, 1086)
end
