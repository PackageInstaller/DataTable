-- 天骄无双
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill313104 = oo.class(SkillBase)
function Skill313104:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill313104:OnBorn(caster, target, data)
	-- 8384
	self:tFunc_8384_8374(caster, target, data)
	self:tFunc_8384_8314(caster, target, data)
	self:tFunc_8384_8315(caster, target, data)
end
-- 伤害后
function Skill313104:OnAfterHurt(caster, target, data)
	-- 8382
	self:tFunc_8382_8372(caster, target, data)
	self:tFunc_8382_8373(caster, target, data)
end
-- 治疗时
function Skill313104:OnCure(caster, target, data)
	-- 8383
	self:tFunc_8383_8352(caster, target, data)
	self:tFunc_8383_8353(caster, target, data)
end
function Skill313104:tFunc_8384_8314(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8147
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.7) then
	else
		return
	end
	-- 8314
	self:AddValue(SkillEffect[8314], caster, self.card, data, "sign2",1)
end
function Skill313104:tFunc_8384_8374(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8341
	local sign1 = SkillApi:GetValue(self, caster, self.card,3,"sign1")
	-- 8361
	if SkillJudger:Less(self, caster, self.card, true,sign1,5) then
	else
		return
	end
	-- 8374
	self:CallSkillEx(SkillEffect[8374], caster, self.card, data, 501800402)
	-- 8311
	self:AddValue(SkillEffect[8311], caster, self.card, data, "sign1",1)
end
function Skill313104:tFunc_8383_8353(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8134
	if SkillJudger:OwnerPercentHp(self, caster, target, true,0.4) then
	else
		return
	end
	-- 8343
	local sign3 = SkillApi:GetValue(self, caster, self.card,3,"sign3")
	-- 8365
	if SkillJudger:Greater(self, caster, self.card, true,sign3,0) then
	else
		return
	end
	-- 8353
	self:DelValue(SkillEffect[8353], caster, self.card, data, "sign3")
end
function Skill313104:tFunc_8382_8373(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8144
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.4) then
	else
		return
	end
	-- 8341
	local sign1 = SkillApi:GetValue(self, caster, self.card,3,"sign1")
	-- 8361
	if SkillJudger:Less(self, caster, self.card, true,sign1,5) then
	else
		return
	end
	-- 8343
	local sign3 = SkillApi:GetValue(self, caster, self.card,3,"sign3")
	-- 8363
	if SkillJudger:Less(self, caster, self.card, true,sign3,1) then
	else
		return
	end
	-- 8373
	self:CallSkill(SkillEffect[8373], caster, self.card, data, 501800401)
	-- 8313
	self:AddValue(SkillEffect[8313], caster, self.card, data, "sign3",1)
	-- 8311
	self:AddValue(SkillEffect[8311], caster, self.card, data, "sign1",1)
end
function Skill313104:tFunc_8383_8352(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8137
	if SkillJudger:OwnerPercentHp(self, caster, target, true,0.7) then
	else
		return
	end
	-- 8342
	local sign2 = SkillApi:GetValue(self, caster, self.card,3,"sign2")
	-- 8364
	if SkillJudger:Greater(self, caster, self.card, true,sign2,0) then
	else
		return
	end
	-- 8352
	self:DelValue(SkillEffect[8352], caster, self.card, data, "sign2")
end
function Skill313104:tFunc_8384_8315(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8144
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.4) then
	else
		return
	end
	-- 8315
	self:AddValue(SkillEffect[8315], caster, self.card, data, "sign3",1)
end
function Skill313104:tFunc_8382_8372(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8147
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.7) then
	else
		return
	end
	-- 8341
	local sign1 = SkillApi:GetValue(self, caster, self.card,3,"sign1")
	-- 8361
	if SkillJudger:Less(self, caster, self.card, true,sign1,5) then
	else
		return
	end
	-- 8342
	local sign2 = SkillApi:GetValue(self, caster, self.card,3,"sign2")
	-- 8362
	if SkillJudger:Less(self, caster, self.card, true,sign2,1) then
	else
		return
	end
	-- 8372
	self:CallSkill(SkillEffect[8372], caster, self.card, data, 501800401)
	-- 8312
	self:AddValue(SkillEffect[8312], caster, self.card, data, "sign2",1)
	-- 8311
	self:AddValue(SkillEffect[8311], caster, self.card, data, "sign1",1)
end
