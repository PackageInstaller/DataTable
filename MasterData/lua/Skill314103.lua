-- 天赋效果314103
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill314103 = oo.class(SkillBase)
function Skill314103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill314103:OnActionOver(caster, target, data)
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
	-- 314103
	self:HitAddBuff(SkillEffect[314103], caster, target, data, 3000,3004)
end
