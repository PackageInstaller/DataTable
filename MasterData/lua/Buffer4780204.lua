-- 星願
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4780204 = oo.class(BuffBase)
function Buffer4780204:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer4780204:OnBefourHurt(caster, target)
	-- 4780221
	self:tFunc_4780221_4780223(caster, target)
	self:tFunc_4780221_4780225(caster, target)
end
-- 创建时
function Buffer4780204:OnCreate(caster, target)
	-- 8771
	local c771 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"crit")
	-- 4780204
	self:AddAttr(BufferEffect[4780204], self.caster, self.card, nil, "attack",math.floor(c771*100*8))
	-- 8771
	local c771 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"crit")
	-- 4780214
	self:AddAttr(BufferEffect[4780214], self.caster, self.creater, nil, "attack",math.floor(c771*100*8))
end
function Buffer4780204:tFunc_4780221_4780225(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8262
	if SkillJudger:IsCallSkill(self, self.caster, target, true) then
	else
		return
	end
	-- 8786
	local c786 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3395)
	-- 4780225
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 4)
	for i,target in ipairs(targets) do
		self:AddTempAttr(BufferEffect[4780225], self.caster, target, nil, "defense",-10*c786)
	end
end
function Buffer4780204:tFunc_4780221_4780223(caster, target)
	-- 8160
	if SkillJudger:IsCasterBuff(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8262
	if SkillJudger:IsCallSkill(self, self.caster, target, true) then
	else
		return
	end
	-- 8786
	local c786 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3395)
	-- 4780223
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 4)
	for i,target in ipairs(targets) do
		self:AddTempAttr(BufferEffect[4780223], self.caster, target, nil, "defense",-10*c786)
	end
end
