-- 聚光漫射
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill403200202 = oo.class(SkillBase)
function Skill403200202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill403200202:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
	-- 403200201
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[403200201], caster, target, data, 2000,3008,2)
end
