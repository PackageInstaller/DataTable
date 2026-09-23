-- 天赋效果307505
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307505 = oo.class(SkillBase)
function Skill307505:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill307505:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 307505
	if self:Rand(6000) then
		self:AddBuff(SkillEffect[307505], caster, self.card, data, 2102)
	end
end
