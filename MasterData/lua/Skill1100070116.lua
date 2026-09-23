-- 多队战斗血量    日+月
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070116 = oo.class(SkillBase)
function Skill1100070116:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 战斗开始
function Skill1100070116:OnStart(caster, target, data)
	-- 1100071321
	self:SetInvincible(SkillEffect[1100071321], caster, target, data, 4,1,1770171,25)
end
-- 攻击结束
function Skill1100070116:OnAttackOver(caster, target, data)
	-- 912100001
	local angler1 = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 1100071323
	if SkillJudger:GreaterEqual(self, caster, target, true,angler1,25) then
	else
		return
	end
end
-- 回合开始时
function Skill1100070116:OnRoundBegin(caster, target, data)
	-- 912100001
	local angler1 = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 1100071323
	if SkillJudger:GreaterEqual(self, caster, target, true,angler1,25) then
	else
		return
	end
end
