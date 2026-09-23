-- 制胜法则
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill306604 = oo.class(SkillBase)
function Skill306604:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill306604:OnBefourHurt(caster, target, data)
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
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 306604
	if self:Rand(4000) then
		self:AddTempAttrPercent(SkillEffect[306604], caster, target, data, "defense",-0.4)
	end
end
