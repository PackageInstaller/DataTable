-- 天赋效果307401
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307401 = oo.class(SkillBase)
function Skill307401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill307401:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 307401
	if self:Rand(2000) then
		self:AddLightShieldCount(SkillEffect[307401], caster, self.card, data, 2309,4,10)
	end
end
