-- 卡尼斯2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill333703 = oo.class(SkillBase)
function Skill333703:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill333703:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 333703
	if self:Rand(3000) then
		self:AddProgress(SkillEffect[333703], caster, self.card, data, 200)
	end
end
