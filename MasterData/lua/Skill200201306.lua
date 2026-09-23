-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200201306 = oo.class(SkillBase)
function Skill200201306:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200201306:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200201306], caster, target, data, 200201306)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200201316], caster, target, data, 200201316)
end
