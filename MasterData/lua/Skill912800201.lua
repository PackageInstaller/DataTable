-- 类植拟态海生物·Ⅰ型_Mimic sea creature type I
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill912800201 = oo.class(SkillBase)
function Skill912800201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill912800201:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 912800201
	self.order = self.order + 1
	self:AddPhysicsShieldCount(SkillEffect[912800201], caster, self.card, data, 2209,2,10)
end
