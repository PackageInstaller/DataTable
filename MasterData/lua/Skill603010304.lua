-- 莫拉鲁塔技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill603010304 = oo.class(SkillBase)
function Skill603010304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill603010304:DoSkill(caster, target, data)
	-- 11008
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11008], caster, target, data, 0.125,8)
end
-- 攻击结束
function Skill603010304:OnAttackOver(caster, target, data)
	-- 8732
	local count732 = SkillApi:SkillLevel(self, caster, target,3,6030101)
	-- 8731
	local count731 = SkillApi:GetCount(self, caster, target,2,603000101)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 603010304
	if self:Rand(4500+1000*count731) then
		self:CallSkill(SkillEffect[603010304], caster, target, data, 603010100+count732)
	end
end
-- 攻击结束2
function Skill603010304:OnAttackOver2(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 603000314
	self:HitAddBuff(SkillEffect[603000314], caster, target, data, 10000,603000304,2)
end
