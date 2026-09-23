-- 被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill950210501 = oo.class(SkillBase)
function Skill950210501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill950210501:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 980100732
	self:tFunc_980100732_980100733(caster, target, data)
	self:tFunc_980100732_980100734(caster, target, data)
end
-- 攻击结束
function Skill950210501:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 980100736
	self:AddBuffCount(SkillEffect[980100736], caster, self.card, data, 980100705,1,100000)
end
function Skill950210501:tFunc_980100732_980100733(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 980100706
	local count980100705 = SkillApi:GetCount(self, caster, target,3,980100705)
	-- 980100707
	if SkillJudger:Equal(self, caster, target, true,(count980100705%2),1) then
	else
		return
	end
	-- 980100733
	self:AddBuff(SkillEffect[980100733], caster, self.card, data, 980100733)
end
function Skill950210501:tFunc_980100732_980100734(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 980100706
	local count980100705 = SkillApi:GetCount(self, caster, target,3,980100705)
	-- 980100708
	if SkillJudger:Equal(self, caster, target, true,(count980100705%2),0) then
	else
		return
	end
	-- 980100734
	self:AddBuff(SkillEffect[980100734], caster, self.card, data, 980100734)
end
