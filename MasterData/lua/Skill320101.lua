-- 磷雾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill320101 = oo.class(SkillBase)
function Skill320101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill320101:OnActionOver(caster, target, data)
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
	-- 320101
	if self:Rand(2000) then
		local targets = SkillFilter:Exception(self, caster, target, 2)
		for i,target in ipairs(targets) do
			self:OwnerAddBuffCount(SkillEffect[320101], caster, target, data, 402000101,1,6)
		end
	end
end
