-- 回生
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4200702 = oo.class(SkillBase)
function Skill4200702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill4200702:OnDeath(caster, target, data)
	-- 8254
	if SkillJudger:IsLive(self, caster, self.card, true) then
	else
		return
	end
	-- 8072
	if SkillJudger:TargetIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 93002
	if SkillJudger:CheckCD(self, caster, target, false) then
	else
		return
	end
	-- 8253
	if SkillJudger:IsLive(self, caster, target, false) then
	else
		return
	end
	-- 4200702
	self:PassiveRevive(SkillEffect[4200702], caster, target, data, 2,0.4,{progress=600})
	-- 4200713
	self:AddBuff(SkillEffect[4200713], caster, self.card, data, 200700101)
	-- 4200714
	self:AddBuff(SkillEffect[4200714], caster, self.card, data, 200700103)
	-- 93003
	self:ResetCD(SkillEffect[93003], caster, target, data, 4)
	-- 4200718
	self:DelBuff(SkillEffect[4200718], caster, self.card, data, 200700104)
	-- 4200720
	self:ShowTips(SkillEffect[4200720], caster, self.card, data, 2,"回生",true,4200720)
	-- 8611
	local count611 = SkillApi:SkillLevel(self, caster, target,3,3239)
	-- 8827
	if SkillJudger:Greater(self, caster, target, true,count611,0) then
	else
		return
	end
	-- 4200712
	self:CallSkill(SkillEffect[4200712], caster, self.card, data, 200700501)
end
-- 行动开始
function Skill4200702:OnActionBegin(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 4200715
	self:DelBuff(SkillEffect[4200715], caster, self.card, data, 200700101)
end
-- 入场时
function Skill4200702:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4200717
	self:AddBuff(SkillEffect[4200717], caster, self.card, data, 200700104)
end
