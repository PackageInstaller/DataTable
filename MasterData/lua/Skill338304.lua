-- 洛贝拉2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill338304 = oo.class(SkillBase)
function Skill338304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill338304:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 338304
	self:AddSp(SkillEffect[338304], caster, self.card, data, 25)
end
-- 特殊入场时(复活，召唤，合体)
function Skill338304:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 338314
	self:AddSp(SkillEffect[338314], caster, caster, data, 25)
end
-- 回合结束时
function Skill338304:OnRoundOver(caster, target, data)
	-- 338342
	self:tFunc_338342_338322(caster, target, data)
	self:tFunc_338342_338332(caster, target, data)
end
function Skill338304:tFunc_338342_338332(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 338332
	self:AddSp(SkillEffect[338332], caster, caster, data, 10)
end
function Skill338304:tFunc_338342_338322(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 338322
	self:AddSp(SkillEffect[338322], caster, self.card, data, 10)
end
