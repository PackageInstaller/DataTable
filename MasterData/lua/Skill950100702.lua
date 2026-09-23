-- 小怪（劣化陷阱）技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill950100702 = oo.class(SkillBase)
function Skill950100702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill950100702:OnActionOver(caster, target, data)
	-- 8065
	if SkillJudger:CasterIsSummoner(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 950100704
	self:CallOwnerSkill(SkillEffect[950100704], caster, target, data, 900600101)
end
