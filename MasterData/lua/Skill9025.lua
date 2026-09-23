-- 额外行动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9025 = oo.class(SkillBase)
function Skill9025:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill9025:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 902501
	self:AddBuff(SkillEffect[902501], caster, self.card, data, 902501)
	-- 8483
	local count83 = SkillApi:BuffCount(self, caster, target,3,3,902501)
	-- 8172
	if SkillJudger:Greater(self, caster, target, true,count83,4) then
	else
		return
	end
	-- 9025
	self:ExtraRound(SkillEffect[9025], caster, self.card, data, nil)
	-- 902502
	self:DelBufferForce(SkillEffect[902502], caster, self.card, data, 902501,10)
end
