-- 第五章小怪被动四
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill110008025 = oo.class(SkillBase)
function Skill110008025:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill110008025:OnBefourHurt(caster, target, data)
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
	-- 8093
	if SkillJudger:TargetPercentHp(self, caster, target, true,0.8) then
	else
		return
	end
	-- 110008025
	self:AddTempAttr(SkillEffect[110008025], caster, self.card, data, "damage",0.15)
end
