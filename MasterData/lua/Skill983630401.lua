-- 摩羯座小怪3技能4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill983630401 = oo.class(SkillBase)
function Skill983630401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill983630401:DoSkill(caster, target, data)
	-- 983630218
	self.order = self.order + 1
	self:AddBuff(SkillEffect[983630218], caster, self.card, data, 983630218)
end
