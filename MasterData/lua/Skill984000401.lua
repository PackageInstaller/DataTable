-- 双子宫
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984000401 = oo.class(SkillBase)
function Skill984000401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill984000401:DoSkill(caster, target, data)
	-- 11012
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11012], caster, target, data, 1,1)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 攻击结束
function Skill984000401:OnAttackOver(caster, target, data)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 984000401
	self:DelBuffQuality(SkillEffect[984000401], caster, target, data, 1,99)
	-- 984000402
	self:AddBuff(SkillEffect[984000402], caster, target, data, 984010303)
	-- 984000403
	self:DelBuffQuality(SkillEffect[984000403], caster, self.card, data, 1,9)
end
