-- 伺机而动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4401903 = oo.class(SkillBase)
function Skill4401903:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4401903:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4401903
	if self:Rand(6000) then
		self:AddSp(SkillEffect[4401903], caster, self.card, data, 20)
	end
end
