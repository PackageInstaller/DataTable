-- 多队战斗血量    提泽娜+机神
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070118 = oo.class(SkillBase)
function Skill1100070118:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 战斗开始
function Skill1100070118:OnStart(caster, target, data)
	-- 1100071331
	self:SetInvincible(SkillEffect[1100071331], caster, target, data, 4,1,4383144,25)
end
-- 攻击结束
function Skill1100070118:OnAttackOver(caster, target, data)
	-- 912100001
	local angler1 = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 1100071333
	if SkillJudger:GreaterEqual(self, caster, target, true,angler1,25) then
	else
		return
	end
end
-- 回合开始时
function Skill1100070118:OnRoundBegin(caster, target, data)
	-- 912100001
	local angler1 = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 1100071333
	if SkillJudger:GreaterEqual(self, caster, target, true,angler1,25) then
	else
		return
	end
end
