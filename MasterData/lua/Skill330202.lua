-- 宙斯天赋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill330202 = oo.class(SkillBase)
function Skill330202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill330202:OnActionBegin(caster, target, data)
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
	-- 330202
	self:OwnerAddBuff(SkillEffect[330202], caster, caster, data, 330202,1)
end
