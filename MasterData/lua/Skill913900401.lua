-- 科拉达机神boss技能4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913900401 = oo.class(SkillBase)
function Skill913900401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill913900401:DoSkill(caster, target, data)
	-- 12006
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12006], caster, target, data, 0.167,6)
end
-- 攻击结束
function Skill913900401:OnAttackOver(caster, target, data)
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
	-- 803600301
	self:LimitDamage(SkillEffect[803600301], caster, target, data, 0.1,8)
end
-- 攻击结束2
function Skill913900401:OnAttackOver2(caster, target, data)
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
	-- 8722
	local count722 = SkillApi:GetCount(self, caster, target,2,603100101)
	-- 913900104
	self:AddBuffCount(SkillEffect[913900104], caster, target, data, 913800101,2,45)
end
-- 行动结束
function Skill913900401:OnActionOver(caster, target, data)
	-- 913900505
	self:tFunc_913900505_913900501(caster, target, data)
	self:tFunc_913900505_913900502(caster, target, data)
	self:tFunc_913900505_913900503(caster, target, data)
	self:tFunc_913900505_913900511(caster, target, data)
end
function Skill913900401:tFunc_913900505_913900501(caster, target, data)
	-- 8061
	if SkillJudger:CasterIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 913900506
	if SkillJudger:Less(self, caster, self.card, true,count18,30) then
	else
		return
	end
	-- 913900501
	local targets = SkillFilter:Rand(self, caster, target, 2)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[913900501], caster, target, data, 913900101)
	end
end
function Skill913900401:tFunc_913900505_913900503(caster, target, data)
	-- 8061
	if SkillJudger:CasterIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 8932
	if SkillJudger:GreaterEqual(self, caster, self.card, true,count18,50) then
	else
		return
	end
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 8933
	if SkillJudger:Less(self, caster, self.card, true,count18,100) then
	else
		return
	end
	-- 913900503
	self:CallOwnerSkill(SkillEffect[913900503], caster, target, data, 913900301)
end
function Skill913900401:tFunc_913900505_913900502(caster, target, data)
	-- 8061
	if SkillJudger:CasterIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 913900507
	if SkillJudger:GreaterEqual(self, caster, self.card, true,count18,30) then
	else
		return
	end
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 8931
	if SkillJudger:Less(self, caster, self.card, true,count18,50) then
	else
		return
	end
	-- 913900502
	local targets = SkillFilter:Rand(self, caster, target, 2)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[913900502], caster, target, data, 913900201)
	end
end
function Skill913900401:tFunc_913900505_913900511(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 8934
	if SkillJudger:GreaterEqual(self, caster, self.card, true,count18,100) then
	else
		return
	end
	-- 913900511
	self:AddSp(SkillEffect[913900511], caster, self.card, data, -100)
	-- 8061
	if SkillJudger:CasterIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 913900504
	self:CallOwnerSkill(SkillEffect[913900504], caster, target, data, 913900401)
end
