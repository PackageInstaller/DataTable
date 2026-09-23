-- 深塔计划怪物buff1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5900001 = oo.class(SkillBase)
function Skill5900001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合结束时
function Skill5900001:OnRoundOver(caster, target, data)
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
	-- 5900001
	self:AddBuff(SkillEffect[5900001], caster, self.card, data, 5900001)
end
