-- 震懾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24111 = oo.class(BuffBase)
function Buffer24111:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer24111:OnRoundBegin(caster, target)
	-- 24171
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(BufferEffect[24171], self.caster, target, nil, 24129)
	end
end
-- 行动结束
function Buffer24111:OnActionOver(caster, target)
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
	-- 24141
	self:AddBuff(BufferEffect[24141], self.caster, self.card, nil, 24114)
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
	-- 24144
	self:DelBufferForce(BufferEffect[24144], self.caster, self.card, nil, 24111)
end
-- 创建时
function Buffer24111:OnCreate(caster, target)
	-- 24171
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(BufferEffect[24171], self.caster, target, nil, 24129)
	end
end
