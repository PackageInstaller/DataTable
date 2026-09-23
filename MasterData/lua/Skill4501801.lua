-- 振翅
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4501801 = oo.class(SkillBase)
function Skill4501801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4501801:OnBorn(caster, target, data)
	-- 8381
	self:tFunc_8381_8371(caster, target, data)
	self:tFunc_8381_8314(caster, target, data)
	self:tFunc_8381_8315(caster, target, data)
end
function Skill4501801:tFunc_8381_8371(caster, target, data)
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
	-- 8371
	self:CallSkillEx(SkillEffect[8371], caster, self.card, data, 501800401)
	-- 8311
	self:AddValue(SkillEffect[8311], caster, self.card, data, "sign1",1)
end
function Skill4501801:tFunc_8381_8314(caster, target, data)
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
function Skill4501801:tFunc_8381_8315(caster, target, data)
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
