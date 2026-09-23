-- 天启难度修改技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill908800302 = oo.class(SkillBase)
function Skill908800302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill908800302:DoSkill(caster, target, data)
	-- 12003
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12003], caster, target, data, 0.333,3)
end
-- 攻击结束
function Skill908800302:OnAttackOver(caster, target, data)
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
	-- 908800306
	self:AddBuffCount(SkillEffect[908800306], caster, target, data, 908800306,1,20)
	-- 908800309
	local count908800306 = SkillApi:GetCount(self, caster, target,3,908800306)
	-- 908800308
	if SkillJudger:Greater(self, caster, target, true,count908800306,19) then
	else
		return
	end
	-- 908800310
	self:CallOwnerSkill(SkillEffect[908800310], caster, self.card, data, 908800701)
	-- 908800309
	local count908800306 = SkillApi:GetCount(self, caster, target,3,908800306)
	-- 908800308
	if SkillJudger:Greater(self, caster, target, true,count908800306,19) then
	else
		return
	end
	-- 908800307
	self:DelBufferForce(SkillEffect[908800307], caster, self.card, data, 908800306,20)
end
-- 回合开始时
function Skill908800302:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 908800311
	self:DelBufferForce(SkillEffect[908800311], caster, self.card, data, 908800306,20)
end
