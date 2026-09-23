-- 天赋效果311204
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill311204 = oo.class(SkillBase)
function Skill311204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill311204:OnActionBegin(caster, target, data)
	-- 8061
	if SkillJudger:CasterIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 311204
	self:Cure(SkillEffect[311204], caster, caster, data, 6,0.05)
end
