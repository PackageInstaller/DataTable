-- 震懾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24102 = oo.class(BuffBase)
function Buffer24102:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer24102:OnRoundBegin(caster, target)
	-- 24162
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(BufferEffect[24162], self.caster, target, nil, 24120)
	end
end
-- 行动结束
function Buffer24102:OnActionOver(caster, target)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, self.caster, target, true) then
	else
		return
	end
	-- 8259
	if SkillJudger:IsCanHurt(self, self.caster, target, true) then
	else
		return
	end
	-- 24105
	self:AddBuff(BufferEffect[24105], self.caster, self.card, nil, 24105)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, self.caster, target, true) then
	else
		return
	end
	-- 8259
	if SkillJudger:IsCanHurt(self, self.caster, target, true) then
	else
		return
	end
	-- 24108
	self:DelBufferForce(BufferEffect[24108], self.caster, self.card, nil, 24102)
end
-- 创建时
function Buffer24102:OnCreate(caster, target)
	-- 24162
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(BufferEffect[24162], self.caster, target, nil, 24120)
	end
end
