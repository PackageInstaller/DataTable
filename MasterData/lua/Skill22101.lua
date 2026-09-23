-- 痛击I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill22101 = oo.class(SkillBase)
function Skill22101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill22101:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 22101
	self:AddBuff(SkillEffect[22101], caster, self.card, data, 22101)
end
-- 特殊入场时(复活，召唤，合体)
function Skill22101:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 22111
	self:AddBuff(SkillEffect[22111], caster, caster, data, 22101)
end
