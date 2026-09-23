-- 击退免疫
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4901003 = oo.class(SkillBase)
function Skill4901003:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4901003:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 305903
	if self:Rand(3000) then
		self:AddBuff(SkillEffect[305903], caster, self.card, data, 6107,1)
	end
end
