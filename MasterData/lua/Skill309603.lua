-- 天赋效果309603
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill309603 = oo.class(SkillBase)
function Skill309603:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill309603:OnAfterHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8427
	local count27 = SkillApi:BuffCount(self, caster, target,2,3,1001)
	-- 8122
	if SkillJudger:Greater(self, caster, self.card, true,count27,4) then
	else
		return
	end
	-- 309603
	self:LimitDamage(SkillEffect[309603], caster, target, data, 0.1,1)
	-- 92018
	self:DelBufferForce(SkillEffect[92018], caster, target, data, 1001,1)
end
