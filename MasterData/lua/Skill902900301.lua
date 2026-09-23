-- 震荡射击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill902900301 = oo.class(SkillBase)
function Skill902900301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill902900301:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
	-- 5204
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[5204], caster, target, data, 10000,5204)
end
