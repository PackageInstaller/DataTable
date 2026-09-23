-- 阿努比斯技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703300306 = oo.class(SkillBase)
function Skill703300306:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill703300306:DoSkill(caster, target, data)
	-- 12005
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12005], caster, target, data, 0.2,5)
end
-- 行动结束2
function Skill703300306:OnActionOver2(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 703300302
	self:AddBuff(SkillEffect[703300302], caster, self.card, data, 703300301)
end
-- 攻击结束
function Skill703300306:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8462
	local count62 = SkillApi:GetAttr(self, caster, target,3,"attack")
	-- 8467
	local count67 = SkillApi:GetAttr(self, caster, target,2,"hp")
	-- 8667
	local count667 = SkillApi:BuffCount(self, caster, target,3,4,703300301)
	-- 8877
	if SkillJudger:Greater(self, caster, target, true,count667,0) then
	else
		return
	end
	-- 703300304
	if self:Rand(500) then
		self:AddHp(SkillEffect[703300304], caster, target, data, -math.min(count67,count62*8),1)
	end
end
