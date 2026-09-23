-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4103312 = oo.class(BuffBase)
function Buffer4103312:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer4103312:OnActionOver(caster, target)
	-- 8160
	if SkillJudger:IsCasterBuff(self, self.caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, self.caster, target, true) then
	else
		return
	end
	-- 8414
	local c14 = SkillApi:GetBeDamage(self, self.caster, target or self.owner,3)
	-- 8804
	local c804 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,41033)
	-- 8806
	local c806 = SkillApi:GetCount(self, self.caster, target or self.owner,3,4103305+c804)
	-- 4103322
	if SkillJudger:Greater(self, self.caster, target, true,c806,0) then
	else
		return
	end
	-- 4103321
	self:AddValue(BufferEffect[4103321], self.caster, self.card, nil, "dmg10330",c14)
end
-- 创建时
function Buffer4103312:OnCreate(caster, target)
	-- 8415
	local c15 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"attack")
	-- 8804
	local c804 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,41033)
	-- 8806
	local c806 = SkillApi:GetCount(self, self.caster, target or self.owner,3,4103305+c804)
	-- 4103311
	self:AddAttr(BufferEffect[4103311], self.caster, self.creater, nil, "attack",math.floor(c15*math.min(c806,5)*0.03))
	-- 4103316
	self:AddAttr(BufferEffect[4103316], self.caster, self.card, nil, "attack",-math.floor(c15*math.min(c806,5)*0.03))
	-- 8804
	local c804 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,41033)
	-- 8806
	local c806 = SkillApi:GetCount(self, self.caster, target or self.owner,3,4103305+c804)
	-- 4103322
	if SkillJudger:Greater(self, self.caster, target, true,c806,0) then
	else
		return
	end
	-- 4103330
	self:AddBuffCount(BufferEffect[4103330], self.caster, self.card, nil, 4103305+c804,1,999)
end
