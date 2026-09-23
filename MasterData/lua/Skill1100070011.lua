-- 碎星阵营角色，角色对于被控制中的怪物伤害增加50%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070011 = oo.class(SkillBase)
function Skill1100070011:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100070011:OnBefourHurt(caster, target, data)
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
	-- 8903
	if SkillJudger:HasBuff(self, caster, target, true,2,1,1) then
	else
		return
	end
	-- 1100070011
	self:AddTempAttr(SkillEffect[1100070011], caster, self.card, data, "damage",0.5)
end
