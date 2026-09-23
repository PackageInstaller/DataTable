-- 洛贝拉2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill338305 = oo.class(SkillBase)
function Skill338305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill338305:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 338305
	self:AddSp(SkillEffect[338305], caster, self.card, data, 30)
end
-- 特殊入场时(复活，召唤，合体)
function Skill338305:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 338315
	self:AddSp(SkillEffect[338315], caster, caster, data, 30)
end
-- 回合结束时
function Skill338305:OnRoundOver(caster, target, data)
	-- 338343
	self:tFunc_338343_338323(caster, target, data)
	self:tFunc_338343_338333(caster, target, data)
end
function Skill338305:tFunc_338343_338333(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 338333
	self:AddSp(SkillEffect[338333], caster, caster, data, 15)
end
function Skill338305:tFunc_338343_338323(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 338323
	self:AddSp(SkillEffect[338323], caster, self.card, data, 15)
end
