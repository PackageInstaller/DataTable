-- 痛击II级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill22102 = oo.class(SkillBase)
function Skill22102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill22102:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 22102
	self:AddBuff(SkillEffect[22102], caster, self.card, data, 22102)
end
-- 特殊入场时(复活，召唤，合体)
function Skill22102:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 22112
	self:AddBuff(SkillEffect[22112], caster, caster, data, 22102)
end
