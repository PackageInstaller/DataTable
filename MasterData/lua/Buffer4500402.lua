-- 飛羽
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4500402 = oo.class(BuffBase)
function Buffer4500402:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer4500402:OnActionOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8223
	if SkillJudger:IsNormal(self, self.caster, target, false) then
	else
		return
	end
	-- 8470
	local c70 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3269)
	-- 4500402
	self:LimitDamage(BufferEffect[4500402], self.caster, self.card, nil, 1,0.5+0.05*c70)
	-- 4500406
	self:DelBufferForce(BufferEffect[4500406], self.caster, self.card, nil, 4500402)
	-- 4500407
	self:OwnerAddBuff(BufferEffect[4500407], self.caster, self.card, nil, 4500403)
end
-- 创建时
function Buffer4500402:OnCreate(caster, target)
	-- 8469
	local c69 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3268)
	-- 4500403
	self:AddAttr(BufferEffect[4500403], self.caster, self.card, nil, "bedamage",0.05+0.02*c69)
	-- 8469
	local c69 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3268)
	-- 4500404
	self:AddAttr(BufferEffect[4500404], self.caster, self.card, nil, "becure",-0.1-0.02*c69)
end
