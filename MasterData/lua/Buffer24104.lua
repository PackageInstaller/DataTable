-- 震懾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24104 = oo.class(BuffBase)
function Buffer24104:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer24104:OnRoundBegin(caster, target)
	-- 24164
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(BufferEffect[24164], self.caster, target, nil, 24122)
	end
end
-- 行动结束
function Buffer24104:OnActionOver(caster, target)
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
	-- 24116
	self:AddBuff(BufferEffect[24116], self.caster, self.card, nil, 24107)
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
	-- 24119
	self:DelBufferForce(BufferEffect[24119], self.caster, self.card, nil, 24104)
end
-- 创建时
function Buffer24104:OnCreate(caster, target)
	-- 24164
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(BufferEffect[24164], self.caster, target, nil, 24122)
	end
end
