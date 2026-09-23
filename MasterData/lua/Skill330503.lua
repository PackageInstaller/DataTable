-- 乌琳天赋2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill330503 = oo.class(SkillBase)
function Skill330503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill330503:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 330503
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddSp(SkillEffect[330503], caster, target, data, 9)
	end
end
