-- 净化推进
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill325403 = oo.class(SkillBase)
function Skill325403:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 驱散buff时
function Skill325403:OnDelBuff(caster, target, data)
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
	-- 325403
	self:AddProgress(SkillEffect[325403], caster, target, data, 200)
end
