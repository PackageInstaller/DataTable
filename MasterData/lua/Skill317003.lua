-- 激励
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill317003 = oo.class(SkillBase)
function Skill317003:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill317003:OnActionOver(caster, target, data)
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
	-- 317003
	if self:Rand(500) then
		self:AddBuff(SkillEffect[317003], caster, target, data, 317001)
	end
end
