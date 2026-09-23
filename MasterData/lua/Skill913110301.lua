-- 人马机神高速形态3技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913110301 = oo.class(SkillBase)
function Skill913110301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill913110301:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 913110301
	self.order = self.order + 1
	self:AddBuff(SkillEffect[913110301], caster, self.card, data, 913110301,3)
end
