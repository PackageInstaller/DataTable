-- 摩羯座小怪3技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill983630201 = oo.class(SkillBase)
function Skill983630201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill983630201:DoSkill(caster, target, data)
	-- 983630206
	self.order = self.order + 1
	self:AddBuff(SkillEffect[983630206], caster, self.card, data, 983630206)
end
-- 入场时
function Skill983630201:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 983630211
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[983630211], caster, target, data, 983630211)
	end
end
-- 死亡时
function Skill983630201:OnDeath(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 983630212
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferForce(SkillEffect[983630212], caster, target, data, 983630211,3)
	end
end
-- 特殊入场时(复活，召唤，合体)
function Skill983630201:OnBornSpecial(caster, target, data)
	-- 983630219
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[983630219], caster, target, data, 983630211)
	end
end
-- 行动结束2
function Skill983630201:OnActionOver2(caster, target, data)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 983630217
	self:CallOwnerSkill(SkillEffect[983630217], caster, self.card, data, 983630401)
end
