-- 坍陨天赋2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill330004 = oo.class(SkillBase)
function Skill330004:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill330004:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 330014
	self:AddSp(SkillEffect[330014], caster, self.card, data, 25)
end
-- 特殊入场时(复活，召唤，合体)
function Skill330004:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 330024
	self:AddSp(SkillEffect[330024], caster, self.card.oSummoner, data, 25)
end
