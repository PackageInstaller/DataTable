-- 暗面涌动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill907000101 = oo.class(SkillBase)
function Skill907000101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill907000101:DoSkill(caster, target, data)
	-- 907000101
	self.order = self.order + 1
	self:AddBuff(SkillEffect[907000101], caster, target, data, 4006,1)
end
