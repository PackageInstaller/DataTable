-- 每周boss怪物通用buff2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6200002 = oo.class(SkillBase)
function Skill6200002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill6200002:OnRoundBegin(caster, target, data)
	-- 6200008
	self:tFunc_6200008_6200009(caster, target, data)
	self:tFunc_6200008_6200010(caster, target, data)
	self:tFunc_6200008_6200011(caster, target, data)
end
function Skill6200002:tFunc_6200008_6200010(caster, target, data)
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
	-- 6200010
	self:AddBuff(SkillEffect[6200010], caster, self.card, data, 6200005)
end
function Skill6200002:tFunc_6200008_6200009(caster, target, data)
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
	-- 6200009
	self:AddBuff(SkillEffect[6200009], caster, self.card, data, 6200004)
end
function Skill6200002:tFunc_6200008_6200011(caster, target, data)
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
	-- 6200011
	self:AddBuff(SkillEffect[6200011], caster, self.card, data, 6200006)
end
