-- 被动：重电磁场
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill700100501 = oo.class(SkillBase)
function Skill700100501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill700100501:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 700100302
	self.order = self.order + 1
	self:AddBuff(SkillEffect[700100302], caster, self.card, data, 700100301)
end
