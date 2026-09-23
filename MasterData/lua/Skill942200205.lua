-- 熔铄技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill942200205 = oo.class(SkillBase)
function Skill942200205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill942200205:DoSkill(caster, target, data)
	-- 942200205
	self.order = self.order + 1
	self:AddBuff(SkillEffect[942200205], caster, target, data, 4606,2)
	-- 942200215
	self.order = self.order + 1
	self:AddBuff(SkillEffect[942200215], caster, target, data, 4406,2)
end
