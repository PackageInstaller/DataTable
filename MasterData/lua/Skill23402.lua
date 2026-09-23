-- 物盾II级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill23402 = oo.class(SkillBase)
function Skill23402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill23402:OnBefourHurt(caster, target, data)
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
	-- 23402
	self:AddTempAttr(SkillEffect[23402], caster, caster, data, "damage",0.30)
	-- 234010
	self:ShowTips(SkillEffect[234010], caster, self.card, data, 2,"神力",true,234010)
end
