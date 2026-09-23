-- 全体退条
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4302602 = oo.class(BuffBase)
function Buffer4302602:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始处理完成后
function Buffer4302602:OnAfterRoundBegin(caster, target)
	-- 8144
	if SkillJudger:OwnerPercentHp(self, self.caster, target, false,0.4) then
	else
		return
	end
	-- 4302602
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 4)
	for i,target in ipairs(targets) do
		self:AddProgress(BufferEffect[4302602], self.caster, target, nil, -200)
	end
	-- 4302604
	self:DelBufferForce(BufferEffect[4302604], self.caster, self.card, nil, 4302602)
end
-- 行动结束
function Buffer4302602:OnActionOver(caster, target)
	-- 8144
	if SkillJudger:OwnerPercentHp(self, self.caster, target, false,0.4) then
	else
		return
	end
	-- 4302602
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 4)
	for i,target in ipairs(targets) do
		self:AddProgress(BufferEffect[4302602], self.caster, target, nil, -200)
	end
	-- 4302604
	self:DelBufferForce(BufferEffect[4302604], self.caster, self.card, nil, 4302602)
end
