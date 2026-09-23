-- 琶音天赋2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill329603 = oo.class(SkillBase)
function Skill329603:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill329603:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 329603
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddProgress(SkillEffect[329603], caster, target, data, 60)
	end
end
