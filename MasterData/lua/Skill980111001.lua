-- 暴虐被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill980111001 = oo.class(SkillBase)
function Skill980111001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合结束时
function Skill980111001:OnRoundOver(caster, target, data)
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
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 980110001
	self:AddBuff(SkillEffect[980110001], caster, self.card, data, 980110001)
end
