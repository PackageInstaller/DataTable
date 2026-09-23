-- 逆行护盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill102200302 = oo.class(SkillBase)
function Skill102200302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill102200302:DoSkill(caster, target, data)
	-- 102200301
	self.order = self.order + 1
	self:OwnerAddBuffCount(SkillEffect[102200301], caster, target, data, 102200301,3,6)
end
-- 回合结束时
function Skill102200302:OnRoundOver(caster, target, data)
	-- 8712
	local count712 = SkillApi:SkillLevel(self, caster, target,3,1022003)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8713
	local count713 = SkillApi:BuffCount(self, caster, target,1,4,102200301)
	-- 8924
	if SkillJudger:Greater(self, caster, target, true,count713,0) then
	else
		return
	end
	-- 102200302
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[102200302], caster, target, data, 102200400+count712)
	end
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8713
	local count713 = SkillApi:BuffCount(self, caster, target,1,4,102200301)
	-- 8924
	if SkillJudger:Greater(self, caster, target, true,count713,0) then
	else
		return
	end
	-- 102200303
	self:OwnerAddBuffCount(SkillEffect[102200303], caster, caster, data, 102200301,-1,6)
end
-- 死亡时
function Skill102200302:OnDeath(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 102200304
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferForce(SkillEffect[102200304], caster, target, data, 102200201)
	end
	-- 102200305
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferForce(SkillEffect[102200305], caster, target, data, 102200301)
	end
end
