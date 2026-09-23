-- 沉默爆炸
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill901000401 = oo.class(SkillBase)
function Skill901000401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill901000401:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
	-- 3002
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[3002], caster, target, data, 10000,3002)
end
