-- 压制击退
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill317305 = oo.class(SkillBase)
function Skill317305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill317305:OnAfterHurt(caster, target, data)
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
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 317305
	if self:Rand(3000) then
		self:AddProgress(SkillEffect[317305], caster, target, data, -200)
	end
end
