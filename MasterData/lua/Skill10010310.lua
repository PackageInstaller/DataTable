-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill10010310 = oo.class(SkillBase)
function Skill10010310:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill10010310:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[2102], caster, target, data, 2102)
	self.order = self.order + 1
	self:AddSp(SkillEffect[81002], caster, target, data, 25)
end
