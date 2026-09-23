-- 坍陨天赋2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill330002 = oo.class(SkillBase)
function Skill330002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill330002:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 330012
	self:AddSp(SkillEffect[330012], caster, self.card, data, 15)
end
-- 特殊入场时(复活，召唤，合体)
function Skill330002:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 330022
	self:AddSp(SkillEffect[330022], caster, self.card.oSummoner, data, 15)
end
