-- 我方单位使用非伤害技能时，40%的概率额外能量值额外+5
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010110 = oo.class(SkillBase)
function Skill1100010110:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill1100010110:OnActionOver(caster, target, data)
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
	-- 1100010110
	if self:Rand(4000) then
		self:AddNp(SkillEffect[1100010110], caster, caster, data, 5)
	end
end
