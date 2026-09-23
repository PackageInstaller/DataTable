-- 我方单位使用非伤害技能时，70%的概率额外NP额外+5
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010111 = oo.class(SkillBase)
function Skill1100010111:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill1100010111:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8221
	if SkillJudger:IsCanHurt(self, caster, target, false) then
	else
		return
	end
	-- 1100010111
	if self:Rand(7000) then
		self:AddNp(SkillEffect[1100010111], caster, caster, data, 5)
	end
end
