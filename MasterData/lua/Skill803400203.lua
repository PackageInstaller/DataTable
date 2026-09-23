-- 仲裁者2（怪物）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill803400203 = oo.class(SkillBase)
function Skill803400203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill803400203:DoSkill(caster, target, data)
	-- 803400203
	self.order = self.order + 1
	self:AddBuff(SkillEffect[803400203], caster, target, data, 2191)
end
