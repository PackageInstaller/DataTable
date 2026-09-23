-- 清晰
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307701 = oo.class(SkillBase)
function Skill307701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill307701:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 307701
	if self:Rand(3000) then
		self:DelBuffQuality(SkillEffect[307701], caster, self.card, data, 2,1)
	end
end
