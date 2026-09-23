-- 天赋效果307203
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307203 = oo.class(SkillBase)
function Skill307203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill307203:OnAfterHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 307203
	if self:Rand(3200) then
		local targets = SkillFilter:All(self, caster, target, 1)
		for i,target in ipairs(targets) do
			self:AddBuff(SkillEffect[307203], caster, target, data, 4204)
		end
	end
end
