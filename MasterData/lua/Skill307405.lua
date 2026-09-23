-- 天赋效果307405
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307405 = oo.class(SkillBase)
function Skill307405:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill307405:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 307405
	if self:Rand(6000) then
		self:AddLightShieldCount(SkillEffect[307405], caster, self.card, data, 2309,4,10)
	end
end
