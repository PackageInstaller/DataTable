-- 天赋效果305503
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305503 = oo.class(SkillBase)
function Skill305503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill305503:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 305503
	if self:Rand(3000) then
		self:AddBuff(SkillEffect[305503], caster, self.card, data, 4504,1)
	end
end
