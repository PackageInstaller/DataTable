-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4302101 = oo.class(SkillBase)
function Skill4302101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4302101:OnBorn(caster, target, data)
	self:tFunc_8381_8371(caster, target, data)
	self:tFunc_8381_8314(caster, target, data)
	self:tFunc_8381_8315(caster, target, data)
end
function Skill4302101:tFunc_8381_8371(caster, target, data)
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
function Skill4302101:tFunc_8381_8314(caster, target, data)
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
function Skill4302101:tFunc_8381_8315(caster, target, data)
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
