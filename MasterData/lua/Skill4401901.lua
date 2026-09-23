-- 伺机而动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4401901 = oo.class(SkillBase)
function Skill4401901:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4401901:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4401901
	if self:Rand(4000) then
		self:AddSp(SkillEffect[4401901], caster, self.card, data, 20)
	end
end
