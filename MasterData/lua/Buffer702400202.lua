-- 寒霜守護
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer702400202 = oo.class(BuffBase)
function Buffer702400202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer702400202:OnActionOver(caster, target)
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
	-- 8477
	local c77 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3290)
	-- 702400201
	self:OwnerHitAddBuff(BufferEffect[702400201], self.caster, self.caster, nil, 1000+c77*200,3005,1)
	-- 8478
	local c78 = SkillApi:BuffCount(self, self.caster, target or self.owner,1,4,23)
	-- 8625
	if SkillJudger:Greater(self, self.caster, self.card, true,c78,0) then
	else
		return
	end
	-- 8477
	local c77 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3290)
	-- 8626
	if SkillJudger:Greater(self, self.caster, self.card, true,c77,0) then
	else
		return
	end
	-- 702400204
	self:AddBuff(BufferEffect[702400204], self.caster, self.caster, nil, 3005,1)
	-- 702400205
	self:DelBufferTypeForce(BufferEffect[702400205], self.caster, self.caster, nil, 23,2)
end
-- 创建时
function Buffer702400202:OnCreate(caster, target)
	-- 4903
	self:AddAttr(BufferEffect[4903], self.caster, target or self.owner, nil,"bedamage",-0.15)
end
