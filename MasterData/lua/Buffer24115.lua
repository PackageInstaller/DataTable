-- 震懾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24115 = oo.class(BuffBase)
function Buffer24115:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer24115:OnRoundBegin(caster, target)
	-- 24175
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(BufferEffect[24175], self.caster, target, nil, 24133)
	end
end
-- 行动结束
function Buffer24115:OnActionOver(caster, target)
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
	-- 24154
	self:AddBuff(BufferEffect[24154], self.caster, self.card, nil, 24118)
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
	-- 24157
	self:DelBufferForce(BufferEffect[24157], self.caster, self.card, nil, 24115)
end
-- 创建时
function Buffer24115:OnCreate(caster, target)
	-- 24175
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(BufferEffect[24175], self.caster, target, nil, 24133)
	end
end
