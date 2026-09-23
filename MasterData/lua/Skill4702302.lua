-- 弹药填装
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4702302 = oo.class(SkillBase)
function Skill4702302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill4702302:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4702302
	if self:Rand(2000) then
		self:AddSp(SkillEffect[4702302], caster, self.card, data, 20)
	end
end
