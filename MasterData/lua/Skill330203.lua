-- 宙斯天赋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill330203 = oo.class(SkillBase)
function Skill330203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill330203:OnActionBegin(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 330203
	self:OwnerAddBuff(SkillEffect[330203], caster, caster, data, 330203,1)
end
