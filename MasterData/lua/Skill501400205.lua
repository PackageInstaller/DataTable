-- 掩护指令
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill501400205 = oo.class(SkillBase)
function Skill501400205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill501400205:DoSkill(caster, target, data)
	-- 6101
	self.order = self.order + 1
	self:AddBuff(SkillEffect[6101], caster, target, data, 6101)
	-- 501400205
	self.order = self.order + 1
	self:AddBuff(SkillEffect[501400205], caster, target, data, 501400205)
end
