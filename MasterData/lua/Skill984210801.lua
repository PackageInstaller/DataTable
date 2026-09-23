-- 狮子座狂暴形态被动3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984210801 = oo.class(SkillBase)
function Skill984210801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill984210801:OnActionOver(caster, target, data)
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
	-- 984210801
	self:CallSkill(SkillEffect[984210801], caster, target, data, 984210101)
end
