-- 天赋效果305303
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305303 = oo.class(SkillBase)
function Skill305303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill305303:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 305303
	if self:Rand(2000) then
		self:AddBuff(SkillEffect[305303], caster, self.card, data, 4204)
	end
end
