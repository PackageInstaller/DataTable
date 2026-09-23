-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4103402 = oo.class(BuffBase)
function Buffer4103402:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer4103402:OnRoundBegin(caster, target)
	-- 4103407
	if self:Rand(math.floor(self.nCount/30)*10000) then
		self:AddBuff(BufferEffect[4103407], self.caster, self.card, nil, 4103407)
	end
end
-- 伤害前
function Buffer4103402:OnBefourHurt(caster, target)
	-- 8771
	local c771 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"crit")
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
	-- 8224
	if SkillJudger:IsCrit(self, self.caster, target, false) then
	else
		return
	end
	-- 4103412
	if self:Rand(10000-math.floor(self.nCount/30)*10000) then
		self:AddTempAttr(BufferEffect[4103412], self.caster, self.card, nil, "damage",(c771-1)*0.1)
	end
end
-- 创建时
function Buffer4103402:OnCreate(caster, target)
	-- 8447
	local c47 = SkillApi:GetAttr(self, self.caster, target or self.owner,4,"defense")
	-- 8796
	local c796 = SkillApi:BuffCount(self, self.caster, target or self.owner,3,4,103400301)
	-- 8797
	local c797 = SkillApi:BuffCount(self, self.caster, target or self.owner,3,4,103401301)
	-- 8798
	local c798 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,41034)
	-- 4103402
	self:AddAttr(BufferEffect[4103402], self.caster, self.card, nil, "attack",math.floor(math.floor(c47/100)*8*self.nCount*(1+c796*math.floor(c798/2+0.5)*0.1+c797*(math.floor(c798/2+0.5)*0.1+0.2))))
	-- 4103407
	if self:Rand(math.floor(self.nCount/30)*10000) then
		self:AddBuff(BufferEffect[4103407], self.caster, self.card, nil, 4103407)
	end
end
