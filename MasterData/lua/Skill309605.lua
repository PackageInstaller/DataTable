-- 天赋效果309605
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill309605 = oo.class(SkillBase)
function Skill309605:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill309605:OnAfterHurt(caster, target, data)
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
	-- 309605
	self:LimitDamage(SkillEffect[309605], caster, target, data, 0.15,1.5)
	-- 92018
	self:DelBufferForce(SkillEffect[92018], caster, target, data, 1001,1)
end
