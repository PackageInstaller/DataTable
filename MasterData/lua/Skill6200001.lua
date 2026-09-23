-- 每周boss怪物通用buff1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6200001 = oo.class(SkillBase)
function Skill6200001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill6200001:OnRoundBegin(caster, target, data)
	-- 6200007
	self:tFunc_6200007_6200001(caster, target, data)
	self:tFunc_6200007_6200005(caster, target, data)
	self:tFunc_6200007_6200006(caster, target, data)
end
function Skill6200001:tFunc_6200007_6200006(caster, target, data)
	-- 907800607
	local playerturn = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 6200004
	if SkillJudger:Equal(self, caster, target, true,playerturn,30) then
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
	-- 6200006
	self:AddBuff(SkillEffect[6200006], caster, self.card, data, 6200003)
end
function Skill6200001:tFunc_6200007_6200001(caster, target, data)
	-- 907800607
	local playerturn = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 6200002
	if SkillJudger:Equal(self, caster, target, true,playerturn,10) then
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
	-- 6200001
	self:AddBuff(SkillEffect[6200001], caster, self.card, data, 6200001)
end
function Skill6200001:tFunc_6200007_6200005(caster, target, data)
	-- 907800607
	local playerturn = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 6200003
	if SkillJudger:Equal(self, caster, target, true,playerturn,20) then
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
	-- 6200005
	self:AddBuff(SkillEffect[6200005], caster, self.card, data, 6200002)
end
