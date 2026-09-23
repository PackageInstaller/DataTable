-- 卡尼斯2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill333705 = oo.class(SkillBase)
function Skill333705:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill333705:OnActionOver(caster, target, data)
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
	-- 333705
	if self:Rand(5000) then
		self:AddProgress(SkillEffect[333705], caster, self.card, data, 200)
	end
end
