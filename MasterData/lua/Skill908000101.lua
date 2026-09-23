-- 战术嘲讽
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill908000101 = oo.class(SkillBase)
function Skill908000101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill908000101:DoSkill(caster, target, data)
	-- 908000101
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[908000101], caster, target, data, 10000,3001,1)
end
