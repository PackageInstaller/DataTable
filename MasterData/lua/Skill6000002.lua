-- 连锁阵线第一期buff2（通用中长轴）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6000002 = oo.class(SkillBase)
function Skill6000002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill6000002:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 60000020
	self:AddBuff(SkillEffect[60000020], caster, self.card, data, 4810)
end
-- 回合结束时
function Skill6000002:OnRoundOver(caster, target, data)
	-- 907800607
	local playerturn = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 60000022
	if SkillJudger:Equal(self, caster, target, true,(playerturn%1),0) then
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
	-- 60000021
	self:AddBuff(SkillEffect[60000021], caster, self.card, data, 60000021)
end
