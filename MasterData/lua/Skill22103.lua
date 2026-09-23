-- 痛击III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill22103 = oo.class(SkillBase)
function Skill22103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill22103:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 22103
	self:AddBuff(SkillEffect[22103], caster, self.card, data, 22103)
end
-- 特殊入场时(复活，召唤，合体)
function Skill22103:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 22113
	self:AddBuff(SkillEffect[22113], caster, caster, data, 22103)
end
