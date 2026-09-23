-- 天赋效果307501
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307501 = oo.class(SkillBase)
function Skill307501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill307501:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 307501
	if self:Rand(2000) then
		self:AddBuff(SkillEffect[307501], caster, self.card, data, 2102)
	end
end
