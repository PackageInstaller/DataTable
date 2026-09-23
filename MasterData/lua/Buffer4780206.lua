-- 星願（強化）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4780206 = oo.class(BuffBase)
function Buffer4780206:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer4780206:OnBefourHurt(caster, target)
	-- 4780222
	self:tFunc_4780222_4780224(caster, target)
	self:tFunc_4780222_4780226(caster, target)
end
-- 创建时
function Buffer4780206:OnCreate(caster, target)
	-- 8771
	local c771 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"crit")
	-- 4780206
	self:AddAttr(BufferEffect[4780206], self.caster, self.card, nil, "attack",math.floor(c771*100*8))
	-- 8771
	local c771 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"crit")
	-- 4780216
	self:AddAttr(BufferEffect[4780216], self.caster, self.creater, nil, "attack",math.floor(c771*100*8))
end
function Buffer4780206:tFunc_4780222_4780224(caster, target)
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
	-- 4780224
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 4)
	for i,target in ipairs(targets) do
		self:AddTempAttr(BufferEffect[4780224], self.caster, target, nil, "defense",-20*c786)
	end
end
function Buffer4780206:tFunc_4780222_4780226(caster, target)
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
	-- 4780226
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 4)
	for i,target in ipairs(targets) do
		self:AddTempAttr(BufferEffect[4780226], self.caster, target, nil, "defense",-20*c786)
	end
end
