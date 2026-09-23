-- 差速冲击（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill401901303 = oo.class(SkillBase)
function Skill401901303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill401901303:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
	-- 5225
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[5225], caster, target, data, 10000,5205,3)
end
