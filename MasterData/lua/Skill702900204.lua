-- 拦截爆弹
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill702900204 = oo.class(SkillBase)
function Skill702900204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill702900204:DoSkill(caster, target, data)
	-- 11091
	self.order = self.order + 1
	self:DamageLight(SkillEffect[11091], caster, target, data, 0.333,1)
	-- 8639
	local count639 = SkillApi:SkillLevel(self, caster, target,3,3280)
	-- 11092
	self.order = self.order + 1
	self:DamageLight(SkillEffect[11092], caster, target, data, 0.03*count639,1)
	-- 11093
	self.order = self.order + 1
	self:DamageLight(SkillEffect[11093], caster, target, data, 0.333,1)
	-- 8639
	local count639 = SkillApi:SkillLevel(self, caster, target,3,3280)
	-- 11094
	self.order = self.order + 1
	self:DamageLight(SkillEffect[11094], caster, target, data, 0.03*count639,1)
	-- 11095
	self.order = self.order + 1
	self:DamageLight(SkillEffect[11095], caster, target, data, 0.333,1)
	-- 8639
	local count639 = SkillApi:SkillLevel(self, caster, target,3,3280)
	-- 11096
	self.order = self.order + 1
	self:DamageLight(SkillEffect[11096], caster, target, data, 0.03*count639,1)
end
-- 攻击结束
function Skill702900204:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8616
	local count616 = SkillApi:GetBeDamage(self, caster, target,3)
	-- 8816
	if SkillJudger:Greater(self, caster, target, true,count616,0) then
	else
		return
	end
	-- 4702807
	self:AddBuff(SkillEffect[4702807], caster, self.card, data, 4702805)
end
