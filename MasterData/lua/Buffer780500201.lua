-- 臨界共生
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer780500201 = oo.class(BuffBase)
function Buffer780500201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动开始
function Buffer780500201:OnActionBegin(caster, target)
	-- 780500228
	self:tFunc_780500228_780500229(caster, target)
	self:tFunc_780500228_780500230(caster, target)
end
-- 伤害后
function Buffer780500201:OnAfterHurt(caster, target)
	-- 780500209
	self:tFunc_780500209_780500210(caster, target)
	self:tFunc_780500209_780500211(caster, target)
end
function Buffer780500201:tFunc_780500228_780500229(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, self.caster, target, true) then
	else
		return
	end
	-- 8264
	if SkillJudger:IsTypeOf(self, self.caster, target, true,7) then
	else
		return
	end
	-- 780500229
	self:DelBufferForce(BufferEffect[780500229], self.caster, self.card, nil, 780500201)
end
function Buffer780500201:tFunc_780500209_780500210(caster, target)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8793
	local c793 = SkillApi:BuffCount(self, self.caster, target or self.owner,2,4,780500299)
	-- 8635
	if SkillJudger:Greater(self, self.caster, self.card, false,c793,0) then
	else
		return
	end
	-- 8151
	if SkillJudger:TargetPercentHp(self, self.caster, target, false,0.001) then
	else
		return
	end
	-- 780500210
	self:SetHP(BufferEffect[780500210], self.caster, self.card, nil, 1)
	-- 780500213
	self:AddBuff(BufferEffect[780500213], self.caster, self.card, nil, 780500299)
	-- 8720
	local c116 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"hp")
	-- 932800204
	local cmaxhp = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"maxhp")
	-- 8792
	local c792 = SkillApi:GetAttr(self, self.caster, target or self.owner,4,"hp")
	-- 8495
	local c95 = SkillApi:GetAttr(self, self.caster, target or self.owner,4,"maxhp")
	-- 780500215
	self:AddHp(BufferEffect[780500215], self.caster, self.card, nil, math.max(math.floor((c116+c792)/(cmaxhp+c95)*cmaxhp-c116),1-c116))
	-- 780500216
	self:AddHp(BufferEffect[780500216], self.caster, self.creater, nil, math.max(-math.floor((c116+c792)/(cmaxhp+c95)*cmaxhp-c116),1-c792))
	-- 780500217
	self:DelBufferForce(BufferEffect[780500217], self.caster, self.card, nil, 780500201)
end
function Buffer780500201:tFunc_780500209_780500211(caster, target)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8161
	if SkillJudger:IsTargetBuff(self, self.caster, target, true) then
	else
		return
	end
	-- 8793
	local c793 = SkillApi:BuffCount(self, self.caster, target or self.owner,2,4,780500299)
	-- 8635
	if SkillJudger:Greater(self, self.caster, self.card, false,c793,0) then
	else
		return
	end
	-- 8151
	if SkillJudger:TargetPercentHp(self, self.caster, target, false,0.001) then
	else
		return
	end
	-- 8795
	local c795 = SkillApi:BuffCount(self, self.caster, target or self.owner,2,4,780500106)
	-- 8637
	if SkillJudger:Greater(self, self.caster, self.card, false,c795,0) then
	else
		return
	end
	-- 780500211
	self:SetHP(BufferEffect[780500211], self.caster, self.creater, nil, 1)
	-- 780500214
	self:AddBuff(BufferEffect[780500214], self.caster, self.creater, nil, 780500299)
	-- 8720
	local c116 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"hp")
	-- 932800204
	local cmaxhp = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"maxhp")
	-- 8792
	local c792 = SkillApi:GetAttr(self, self.caster, target or self.owner,4,"hp")
	-- 8495
	local c95 = SkillApi:GetAttr(self, self.caster, target or self.owner,4,"maxhp")
	-- 780500215
	self:AddHp(BufferEffect[780500215], self.caster, self.card, nil, math.max(math.floor((c116+c792)/(cmaxhp+c95)*cmaxhp-c116),1-c116))
	-- 780500216
	self:AddHp(BufferEffect[780500216], self.caster, self.creater, nil, math.max(-math.floor((c116+c792)/(cmaxhp+c95)*cmaxhp-c116),1-c792))
	-- 780500217
	self:DelBufferForce(BufferEffect[780500217], self.caster, self.card, nil, 780500201)
end
function Buffer780500201:tFunc_780500228_780500230(caster, target)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, self.caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8264
	if SkillJudger:IsTypeOf(self, self.caster, target, true,7) then
	else
		return
	end
	-- 780500230
	self:DelBufferForce(BufferEffect[780500230], self.caster, self.card, nil, 780500201)
end
