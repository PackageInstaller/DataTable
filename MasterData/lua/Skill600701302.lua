-- 机动协调（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill600701302 = oo.class(SkillBase)
function Skill600701302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill600701302:DoSkill(caster, target, data)
	-- 12601
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12601], caster, target, data, 1,1)
	-- 12602
	self.order = self.order + 1
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamagePhysics(SkillEffect[12602], caster, target, data, 1,1)
	end
	-- 12603
	self.order = self.order + 1
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamagePhysics(SkillEffect[12603], caster, target, data, 1,1)
	end
	-- 12604
	self.order = self.order + 1
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamagePhysics(SkillEffect[12604], caster, target, data, 1,1)
	end
	-- 8608
	local count608 = SkillApi:BuffCount(self, caster, target,3,4,600700301)
	-- 8804
	if SkillJudger:Greater(self, caster, target, true,count608,0) then
	else
		return
	end
	-- 12605
	self.order = self.order + 1
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamagePhysics(SkillEffect[12605], caster, target, data, 1,1)
	end
	-- 8608
	local count608 = SkillApi:BuffCount(self, caster, target,3,4,600700301)
	-- 8805
	if SkillJudger:Greater(self, caster, target, true,count608,1) then
	else
		return
	end
	-- 12606
	self.order = self.order + 1
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamagePhysics(SkillEffect[12606], caster, target, data, 1,1)
	end
end
-- 攻击开始
function Skill600701302:OnAttackBegin(caster, target, data)
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
	-- 999999990
	self:AddBuff(SkillEffect[999999990], caster, self.card, data, 999999990)
end
