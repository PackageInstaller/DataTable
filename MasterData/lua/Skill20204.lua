-- 切割III级(怪物用)
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill20204 = oo.class(SkillBase)
function Skill20204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill20204:OnAfterHurt(caster, target, data)
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
	-- 20204
	if self:Rand(3000) then
		self:LimitDamage(SkillEffect[20204], caster, target, data, 0.06,1.2)
		-- 202010
		self:ShowTips(SkillEffect[202010], caster, self.card, data, 2,"切割",true,202010)
	end
end
