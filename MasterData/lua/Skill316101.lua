-- 系统崩溃
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill316101 = oo.class(SkillBase)
function Skill316101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill316101:OnAfterHurt(caster, target, data)
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
	-- 316101
	self:AddUplimitBuff(SkillEffect[316101], caster, target, data, 2,3,316101,20,316101)
end
