-- 护盾爆炸
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill908800301 = oo.class(SkillBase)
function Skill908800301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill908800301:DoSkill(caster, target, data)
	-- 12003
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12003], caster, target, data, 0.333,3)
end
-- 行动结束
function Skill908800301:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 908800303
	self:AddBuffCount(SkillEffect[908800303], caster, self.card, data, 908800303,1,5)
	-- 8663
	local count663 = SkillApi:GetCount(self, caster, target,3,908800303)
	-- 8870
	if SkillJudger:Greater(self, caster, target, true,count663,4) then
	else
		return
	end
	-- 908800305
	self:DelBufferTypeForce(SkillEffect[908800305], caster, self.card, data, 908800303)
	-- 908800301
	self:CallOwnerSkill(SkillEffect[908800301], caster, self.card, data, 908800801)
end
-- 行动结束2
function Skill908800301:OnActionOver2(caster, target, data)
	-- 8662
	local count662 = SkillApi:BuffCount(self, caster, target,3,4,908800302)
	-- 8869
	if SkillJudger:Greater(self, caster, target, true,count662,0) then
	else
		return
	end
	-- 908800304
	self:DelBufferTypeForce(SkillEffect[908800304], caster, self.card, data, 908800302)
	-- 908800302
	self:CallOwnerSkill(SkillEffect[908800302], caster, self.card, data, 908800701)
end
