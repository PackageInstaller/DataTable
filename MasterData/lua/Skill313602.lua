-- 天赋效果313602
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill313602 = oo.class(SkillBase)
function Skill313602:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill313602:OnActionOver(caster, target, data)
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
	-- 313602
	if self:Rand(4000) then
		self:AddSp(SkillEffect[313602], caster, self.card, data, 20)
	end
end
