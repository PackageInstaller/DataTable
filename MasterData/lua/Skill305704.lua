-- 天赋效果305704
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305704 = oo.class(SkillBase)
function Skill305704:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill305704:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 305704
	if self:Rand(4000) then
		self:AddBuff(SkillEffect[305704], caster, self.card, data, 6104,1)
	end
end
