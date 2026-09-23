-- 超音速
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500400205 = oo.class(SkillBase)
function Skill500400205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合结束时
function Skill500400205:OnRoundOver(caster, target, data)
	-- 500400205
	if self:Rand(2500) then
		self:tFunc_500400205_500400206(caster, target, data)
		self:tFunc_500400205_500400207(caster, target, data)
	end
end
function Skill500400205:tFunc_500400205_500400206(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 500400206
	self:Custom(SkillEffect[500400206], caster, self.card, data, "play_ani",{name="cage"})
end
function Skill500400205:tFunc_500400205_500400207(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 500400207
	self:ExtraRound(SkillEffect[500400207], caster, self.card, data, nil)
end
