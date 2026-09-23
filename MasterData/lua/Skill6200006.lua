-- 每周boss索尔达森角色buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6200006 = oo.class(SkillBase)
function Skill6200006:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill6200006:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 6200021
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[6200021], caster, target, data, 6200021)
	end
end
