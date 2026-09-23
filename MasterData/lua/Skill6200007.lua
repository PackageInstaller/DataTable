-- 每周boss怪物通用索尔达森buff3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6200007 = oo.class(SkillBase)
function Skill6200007:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill6200007:OnRoundBegin(caster, target, data)
	-- 6200027
	self:tFunc_6200027_6200028(caster, target, data)
	self:tFunc_6200027_6200029(caster, target, data)
	self:tFunc_6200027_6200030(caster, target, data)
end
function Skill6200007:tFunc_6200027_6200028(caster, target, data)
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
	-- 6200028
	self:AddBuff(SkillEffect[6200028], caster, self.card, data, 6200010)
	-- 6200031
	self:AddBuff(SkillEffect[6200031], caster, self.card, data, 6200007)
end
function Skill6200007:tFunc_6200027_6200030(caster, target, data)
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
	-- 6200030
	self:AddBuff(SkillEffect[6200030], caster, self.card, data, 6200012)
	-- 6200033
	self:AddBuff(SkillEffect[6200033], caster, self.card, data, 6200009)
end
function Skill6200007:tFunc_6200027_6200029(caster, target, data)
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
	-- 6200029
	self:AddBuff(SkillEffect[6200029], caster, self.card, data, 6200011)
	-- 6200032
	self:AddBuff(SkillEffect[6200032], caster, self.card, data, 6200008)
end
