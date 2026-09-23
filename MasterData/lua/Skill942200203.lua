-- 熔铄技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill942200203 = oo.class(SkillBase)
function Skill942200203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill942200203:DoSkill(caster, target, data)
	-- 942200203
	self.order = self.order + 1
	self:AddBuff(SkillEffect[942200203], caster, target, data, 4604,2)
	-- 942200213
	self.order = self.order + 1
	self:AddBuff(SkillEffect[942200213], caster, target, data, 4404,2)
end
