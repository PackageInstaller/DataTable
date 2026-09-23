-- 仲裁者2（怪物）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill803400202 = oo.class(SkillBase)
function Skill803400202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill803400202:DoSkill(caster, target, data)
	-- 803400202
	self.order = self.order + 1
	self:AddBuff(SkillEffect[803400202], caster, target, data, 2109)
end
