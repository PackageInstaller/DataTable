-- 虹光透镜（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill401501305 = oo.class(SkillBase)
function Skill401501305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill401501305:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
	-- 401501303
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[401501303], caster, target, data, 10000,3002,2)
end
