-- 皮洛可3（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200301303 = oo.class(SkillBase)
function Skill200301303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200301303:DoSkill(caster, target, data)
	-- 12003
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12003], caster, target, data, 0.333,3)
	-- 200300303
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[200300303], caster, target, data, 200300303)
	end
end
-- 行动开始
function Skill200301303:OnActionBegin(caster, target, data)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 200300201
	local targets = SkillFilter:MaxAttr(self, caster, target, 1,"attack",1)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[200300201], caster, target, data, 200300111)
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 200300202
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		-- 8778
		local count778 = SkillApi:SkillLevel(self, caster, target,3,3400)
		-- 8779
		local count779 = SkillApi:BuffCount(self, caster, target,2,4,200300111)
		-- 8200
		if SkillJudger:IsCurrSkill(self, caster, target, true) then
		else
			return
		end
		-- 200300203
		if self:Rand(5000-300*count778+1300*count778*count779) then
			self:AddBuff(SkillEffect[200300203], caster, target, data, 200300112)
		end
	end
end
-- 行动结束
function Skill200301303:OnActionOver(caster, target, data)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 200300308
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		-- 8780
		local count780 = SkillApi:BuffCount(self, caster, target,2,4,200300112)
		-- 200300313
		if SkillJudger:Greater(self, caster, target, true,count780,0) then
			-- 200300318
			self:AddBuff(SkillEffect[200300318], caster, target, data, 200300308)
		else
			-- 8777
			local count777 = SkillApi:SkillLevel(self, caster, target,3,42003)
			-- 200300321
			self:AddBuffCount(SkillEffect[200300321], caster, self.card, data, 4200300+count777,1,10)
		end
	end
end
-- 行动结束2
function Skill200301303:OnActionOver2(caster, target, data)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 200301301
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferForce(SkillEffect[200301301], caster, target, data, 200300111)
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 200301302
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferForce(SkillEffect[200301302], caster, target, data, 200300112)
	end
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
	-- 95003
	local targets = SkillFilter:All(self, caster, target, 1)
	for i,target in ipairs(targets) do
		self:AlterBufferByGroup(SkillEffect[95003], caster, target, data, 1,1)
	end
end
-- 攻击开始
function Skill200301303:OnAttackBegin(caster, target, data)
	-- 8777
	local count777 = SkillApi:SkillLevel(self, caster, target,3,42003)
	-- 8782
	local count782 = SkillApi:GetCount(self, caster, target,3,4200300+count777)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8777
	local count777 = SkillApi:SkillLevel(self, caster, target,3,42003)
	-- 200301305
	self:AddBuffCount(SkillEffect[200301305], caster, target, data, 4200305+count777,count782,10)
	-- 200301308
	self:DelBufferTypeForce(SkillEffect[200301308], caster, self.card, data, 4200301)
end
