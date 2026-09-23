-- pvp buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5600005 = oo.class(SkillBase)
function Skill5600005:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合结束时
function Skill5600005:OnRoundOver(caster, target, data)
	-- 5600004
	local playerturn2 = SkillApi:GetStep(self, caster, self.card,nil)
	-- 5600001
	if SkillJudger:Equal(self, caster, target, true,(playerturn2%10),0) then
	else
		return
	end
	-- 5600004
	local playerturn2 = SkillApi:GetStep(self, caster, self.card,nil)
	-- 5600005
	if SkillJudger:Greater(self, caster, self.card, true,playerturn2,0) then
	else
		return
	end
	-- 5600002
	self:AddBuff(SkillEffect[5600002], caster, self.card, data, 5600002)
end
-- 入场时
function Skill5600005:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 5600009
	self:AddBuff(SkillEffect[5600009], caster, self.card, data, 5600009)
end
-- 特殊入场时(复活，召唤，合体)
function Skill5600005:OnBornSpecial(caster, target, data)
	-- 9763
	if SkillJudger:CasterIsUnite(self, caster, self.card, false) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 5600020
	self:AddBuff(SkillEffect[5600020], caster, self.card, data, 5600009)
end
