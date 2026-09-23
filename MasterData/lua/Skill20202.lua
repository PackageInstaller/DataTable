-- 切割II级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill20202 = oo.class(SkillBase)
function Skill20202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill20202:OnAfterHurt(caster, target, data)
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
	-- 20202
	if self:Rand(3000) then
		self:LimitDamage(SkillEffect[20202], caster, target, data, 0.04,0.8)
		-- 202010
		self:ShowTips(SkillEffect[202010], caster, self.card, data, 2,"切割",true,202010)
	end
end
