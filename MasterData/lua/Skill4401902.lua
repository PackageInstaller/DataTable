-- 伺机而动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4401902 = oo.class(SkillBase)
function Skill4401902:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4401902:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4401902
	if self:Rand(5000) then
		self:AddSp(SkillEffect[4401902], caster, self.card, data, 20)
	end
end
