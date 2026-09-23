-- 虹光透镜
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill401500304 = oo.class(SkillBase)
function Skill401500304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill401500304:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
	-- 401500302
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[401500302], caster, target, data, 9000,3002,1)
end
