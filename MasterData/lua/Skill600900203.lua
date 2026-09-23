-- 排压盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill600900203 = oo.class(SkillBase)
function Skill600900203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill600900203:DoSkill(caster, target, data)
	-- 600900203
	self.order = self.order + 1
	self:AddBuff(SkillEffect[600900203], caster, target, data, 2923)
end
