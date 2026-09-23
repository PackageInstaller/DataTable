-- 音符
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill327402 = oo.class(SkillBase)
function Skill327402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill327402:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 327402
	if self:Rand(4000) then
		self:AddBuff(SkillEffect[327402], caster, self.card, data, 200800101)
	end
end
