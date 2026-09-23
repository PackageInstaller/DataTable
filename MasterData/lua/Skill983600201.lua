-- 摩羯座技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill983600201 = oo.class(SkillBase)
function Skill983600201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill983600201:CanSummon()
	return self.card:CanSummon(10000302,3,{1,3},{progress=99},nil,nil)
end
function Skill983600201:CanSummon()
	return self.card:CanSummon(10000301,3,{1,2},{progress=105},nil,nil)
end
function Skill983600201:CanSummon()
	return self.card:CanSummon(10000303,3,{1,1},{progress=100},nil,nil)
end
-- 执行技能
function Skill983600201:DoSkill(caster, target, data)
	-- 983600201
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[983600201], caster, self.card, data, 10000303,3,{1,1},{progress=100},nil,nil)
	-- 983600202
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[983600202], caster, self.card, data, 10000301,3,{1,2},{progress=105},nil,nil)
	-- 983600203
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[983600203], caster, self.card, data, 10000302,3,{1,3},{progress=99},nil,nil)
end
-- 入场时
function Skill983600201:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 983600212
	self:CallOwnerSkill(SkillEffect[983600212], caster, self.card, data, 983600201)
end
-- 回合结束时
function Skill983600201:OnRoundOver(caster, target, data)
	-- 907800607
	local playerturn = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 906100606
	if SkillJudger:Equal(self, caster, target, true,(playerturn%8),0) then
	else
		return
	end
	-- 907800607
	local playerturn = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 907800610
	if SkillJudger:Greater(self, caster, self.card, true,playerturn,0) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 983610215
	self:CallOwnerSkill(SkillEffect[983610215], caster, self.card, data, 983600301)
end
