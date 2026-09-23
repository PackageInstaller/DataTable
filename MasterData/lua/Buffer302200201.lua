-- 遠古咆哮
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer302200201 = oo.class(BuffBase)
function Buffer302200201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer302200201:OnActionOver(caster, target)
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
	-- 302200302
	if SkillJudger:Greater(self, self.caster, target, true,self.nCount,1) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, self.caster, target, true) then
	else
		return
	end
	-- 302200305
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(BufferEffect[302200305], self.caster, target, nil, 302200203,1)
	end
end
-- 创建时
function Buffer302200201:OnCreate(caster, target)
	-- 8450
	local c50 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3022002)
	-- 302200201
	self:AddAttr(BufferEffect[302200201], self.caster, self.card, nil, "damage",0.2*self.nCount)
	-- 8450
	local c50 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3022002)
	-- 302200202
	self:AddAttr(BufferEffect[302200202], self.caster, self.card, nil, "speed",(c50-1)*5*self.nCount)
end
-- 攻击开始
function Buffer302200201:OnAttackBegin(caster, target)
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
	-- 302200303
	if SkillJudger:Greater(self, self.caster, target, true,self.nCount,2) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, self.caster, target, true) then
	else
		return
	end
	-- 302200309
	self:OwnerAddBuff(BufferEffect[302200309], self.caster, self.card, nil, 302200303)
end
