-- 飛羽死亡引爆
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4500404 = oo.class(BuffBase)
function Buffer4500404:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4500404:OnCreate(caster, target)
	-- 8470
	local c70 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3269)
	-- 8471
	local c71 = SkillApi:BuffCount(self, self.caster, target or self.owner,3,3,4500402)
	-- 8471
	local c71 = SkillApi:BuffCount(self, self.caster, target or self.owner,3,3,4500402)
	-- 8623
	if SkillJudger:Greater(self, self.caster, self.card, true,c71,0) then
	else
		return
	end
	-- 4500408
	self:LimitDamage(BufferEffect[4500408], self.caster, self.card, nil, 1,(0.5+0.05*c70)*c71)
	-- 4500409
	self:DelBufferForce(BufferEffect[4500409], self.caster, self.card, nil, 4500402,3)
	-- 4500407
	self:OwnerAddBuff(BufferEffect[4500407], self.caster, self.card, nil, 4500403)
end
