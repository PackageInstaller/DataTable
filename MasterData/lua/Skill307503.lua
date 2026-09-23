-- 天赋效果307503
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307503 = oo.class(SkillBase)
function Skill307503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill307503:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 307503
	if self:Rand(4000) then
		self:AddBuff(SkillEffect[307503], caster, self.card, data, 2102)
	end
end
