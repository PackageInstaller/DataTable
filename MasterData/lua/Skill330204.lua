-- 宙斯天赋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill330204 = oo.class(SkillBase)
function Skill330204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill330204:OnActionBegin(caster, target, data)
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
	-- 330204
	self:OwnerAddBuff(SkillEffect[330204], caster, caster, data, 330204,1)
end
