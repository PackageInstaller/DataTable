-- 洛贝拉2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill338302 = oo.class(SkillBase)
function Skill338302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill338302:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 338302
	self:AddSp(SkillEffect[338302], caster, self.card, data, 15)
end
-- 特殊入场时(复活，召唤，合体)
function Skill338302:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 338312
	self:AddSp(SkillEffect[338312], caster, caster, data, 15)
end
-- 回合结束时
function Skill338302:OnRoundOver(caster, target, data)
	-- 338341
	self:tFunc_338341_338321(caster, target, data)
	self:tFunc_338341_338331(caster, target, data)
end
function Skill338302:tFunc_338341_338331(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 338331
	self:AddSp(SkillEffect[338331], caster, caster, data, 5)
end
function Skill338302:tFunc_338341_338321(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 338321
	self:AddSp(SkillEffect[338321], caster, self.card, data, 5)
end
