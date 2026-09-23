-- 物盾I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill23401 = oo.class(SkillBase)
function Skill23401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill23401:OnBefourHurt(caster, target, data)
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
	-- 23401
	self:AddTempAttr(SkillEffect[23401], caster, caster, data, "damage",0.15)
	-- 234010
	self:ShowTips(SkillEffect[234010], caster, self.card, data, 2,"神力",true,234010)
end
