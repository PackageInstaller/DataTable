-- 卡尼斯2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill333704 = oo.class(SkillBase)
function Skill333704:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill333704:OnActionOver(caster, target, data)
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
	-- 333704
	if self:Rand(4000) then
		self:AddProgress(SkillEffect[333704], caster, self.card, data, 200)
	end
end
