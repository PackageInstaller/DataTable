-- 火力遂穿
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4900502 = oo.class(SkillBase)
function Skill4900502:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4900502:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 305402
	if self:Rand(2000) then
		self:AddBuff(SkillEffect[305402], caster, self.card, data, 4304,1)
	end
end
