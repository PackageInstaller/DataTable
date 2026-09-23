-- 天赋效果314105
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill314105 = oo.class(SkillBase)
function Skill314105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill314105:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8155
	if SkillJudger:IsProgressLess(self, caster, target, true,500) then
	else
		return
	end
	-- 314105
	self:HitAddBuff(SkillEffect[314105], caster, target, data, 8000,3004)
end
