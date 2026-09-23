-- 感知充能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill301801 = oo.class(SkillBase)
function Skill301801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill301801:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 301801
	if self:Rand(2000) then
		self:AddNp(SkillEffect[301801], caster, self.card, data, 10)
	end
end
