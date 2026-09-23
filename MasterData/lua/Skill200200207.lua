-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200200207 = oo.class(SkillBase)
function Skill200200207:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200200207:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200200207], caster, target, data, 200200207)
end
