-- 卡牌10050技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill100500301 = oo.class(SkillBase)
function Skill100500301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill100500301:DoSkill(caster, target, data)
	-- 12004
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12004], caster, target, data, 0.25,4)
	-- 100500301
	self.order = self.order + 1
	self:AddLightShieldCount(SkillEffect[100500301], caster, target, data, 2309,1,10)
end
