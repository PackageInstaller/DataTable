-- 天赋效果305104
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305104 = oo.class(SkillBase)
function Skill305104:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill305104:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 305104
	if self:Rand(4000) then
		self:AddBuff(SkillEffect[305104], caster, self.card, data, 4004,1)
	end
end
