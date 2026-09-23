-- 虚数天灾困难模式buff6
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6300026 = oo.class(SkillBase)
function Skill6300026:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合结束时
function Skill6300026:OnRoundOver(caster, target, data)
	-- 907800607
	local playerturn = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 910600904
	if SkillJudger:Equal(self, caster, target, true,(playerturn%10),0) then
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
	-- 5500127
	self:OwnerAddBuffCount(SkillEffect[5500127], caster, self.card, data, 55001272,10,10)
end
