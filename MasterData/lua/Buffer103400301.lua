-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer103400301 = oo.class(BuffBase)
function Buffer103400301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer103400301:OnRoundBegin(caster, target)
	-- 8798
	local c798 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,41034)
	-- 8800
	local c800 = SkillApi:GetCount(self, self.caster, target or self.owner,3,4103400+c798)
	-- 8799
	local c799 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3408)
	-- 103400306
	if self:Rand(math.floor(c799/5+0.8)*10000) then
		self:AddBuff(BufferEffect[103400306], self.caster, self.card, nil, 103400305+c799+math.floor(c800/30)*5)
	end
end
-- 移除buff时
function Buffer103400301:OnRemoveBuff(caster, target)
	-- 103400307
	self:DelBufferTypeForce(BufferEffect[103400307], self.caster, self.card, nil, 103400306)
end
-- 创建时
function Buffer103400301:OnCreate(caster, target)
	-- 103400301
	self:AddAttr(BufferEffect[103400301], self.caster, self.card, nil, "bedamage",-0.1)
	-- 8798
	local c798 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,41034)
	-- 8800
	local c800 = SkillApi:GetCount(self, self.caster, target or self.owner,3,4103400+c798)
	-- 8799
	local c799 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3408)
	-- 103400306
	if self:Rand(math.floor(c799/5+0.8)*10000) then
		self:AddBuff(BufferEffect[103400306], self.caster, self.card, nil, 103400305+c799+math.floor(c800/30)*5)
	end
end
