-- 皮洛可2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200300204 = oo.class(SkillBase)
function Skill200300204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200300204:DoSkill(caster, target, data)
	-- 200300217
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200300217], caster, target, data, 200300204)
end
-- 行动开始
function Skill200300204:OnActionBegin(caster, target, data)
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
-- 行动结束2
function Skill200300204:OnActionOver2(caster, target, data)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 200300225
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferForce(SkillEffect[200300225], caster, target, data, 200300111)
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 200300226
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferForce(SkillEffect[200300226], caster, target, data, 200300112)
	end
end
-- 行动结束
function Skill200300204:OnActionOver(caster, target, data)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 200300207
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		-- 8780
		local count780 = SkillApi:BuffCount(self, caster, target,2,4,200300112)
		-- 200300212
		if SkillJudger:Greater(self, caster, target, true,count780,0) then
			-- 200300222
			self:AddBuff(SkillEffect[200300222], caster, target, data, 200300209)
		else
			-- 8777
			local count777 = SkillApi:SkillLevel(self, caster, target,3,42003)
			-- 200300224
			self:AddBuffCount(SkillEffect[200300224], caster, self.card, data, 4200300+count777,1,10)
		end
	end
end
