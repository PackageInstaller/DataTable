-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4302102 = oo.class(SkillBase)
function Skill4302102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4302102:OnBorn(caster, target, data)
	self:tFunc_8381_8371(caster, target, data)
	self:tFunc_8381_8314(caster, target, data)
	self:tFunc_8381_8315(caster, target, data)
end
-- 伤害后
function Skill4302102:OnAfterHurt(caster, target, data)
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.7) then
	else
		return
	end
	local sign1 = SkillApi:GetValue(self, caster, self.card,3,"sign1")
	if SkillJudger:Less(self, caster, self.card, true,sign1,5) then
	else
		return
	end
	local sign2 = SkillApi:GetValue(self, caster, self.card,3,"sign2")
	if SkillJudger:Less(self, caster, self.card, true,sign2,1) then
	else
		return
	end
	self:CallSkill(SkillEffect[8372], caster, self.card, data, 501800401)
	self:AddValue(SkillEffect[8312], caster, self.card, data, "sign2",1)
	self:AddValue(SkillEffect[8311], caster, self.card, data, "sign1",1)
end
-- 治疗时
function Skill4302102:OnCure(caster, target, data)
	self:tFunc_8383_8352(caster, target, data)
	self:tFunc_8383_8353(caster, target, data)
end
function Skill4302102:tFunc_8381_8371(caster, target, data)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	local sign1 = SkillApi:GetValue(self, caster, self.card,3,"sign1")
	if SkillJudger:Less(self, caster, self.card, true,sign1,5) then
	else
		return
	end
	self:CallSkillEx(SkillEffect[8371], caster, self.card, data, 501800401)
	self:AddValue(SkillEffect[8311], caster, self.card, data, "sign1",1)
end
function Skill4302102:tFunc_8381_8315(caster, target, data)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.4) then
	else
		return
	end
	self:AddValue(SkillEffect[8315], caster, self.card, data, "sign3",1)
end
function Skill4302102:tFunc_8383_8353(caster, target, data)
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:OwnerPercentHp(self, caster, target, true,0.4) then
	else
		return
	end
	local sign3 = SkillApi:GetValue(self, caster, self.card,3,"sign3")
	if SkillJudger:Greater(self, caster, self.card, true,sign3,0) then
	else
		return
	end
	self:DelValue(SkillEffect[8353], caster, self.card, data, "sign3")
end
function Skill4302102:tFunc_8383_8352(caster, target, data)
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:OwnerPercentHp(self, caster, target, true,0.7) then
	else
		return
	end
	local sign2 = SkillApi:GetValue(self, caster, self.card,3,"sign2")
	if SkillJudger:Greater(self, caster, self.card, true,sign2,0) then
	else
		return
	end
	self:DelValue(SkillEffect[8352], caster, self.card, data, "sign2")
end
function Skill4302102:tFunc_8381_8314(caster, target, data)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.7) then
	else
		return
	end
	self:AddValue(SkillEffect[8314], caster, self.card, data, "sign2",1)
end
