-- 天赋效果307404
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307404 = oo.class(SkillBase)
function Skill307404:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill307404:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 307404
	if self:Rand(5000) then
		self:AddLightShieldCount(SkillEffect[307404], caster, self.card, data, 2309,4,10)
	end
end
