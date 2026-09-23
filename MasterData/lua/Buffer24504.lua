-- 行動提前
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24504 = oo.class(BuffBase)
function Buffer24504:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer24504:OnActionOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 24505
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddProgress(BufferEffect[24505], self.caster, target, nil, 300)
	end
	-- 24506
	self:DelBufferTypeForce(BufferEffect[24506], self.caster, self.card, nil, 24504)
end
