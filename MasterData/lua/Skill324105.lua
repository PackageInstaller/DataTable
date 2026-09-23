-- 抵抗强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill324105 = oo.class(SkillBase)
function Skill324105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill324105:OnActionOver(caster, target, data)
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
	-- 324105
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[324105], caster, target, data, 4606,2)
	end
end
