-- 天赋效果314104
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill314104 = oo.class(SkillBase)
function Skill314104:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill314104:OnActionOver(caster, target, data)
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
	-- 314104
	self:HitAddBuff(SkillEffect[314104], caster, target, data, 4000,3004)
end
