-- 震懾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24118 = oo.class(BuffBase)
function Buffer24118:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer24118:OnRoundBegin(caster, target)
	-- 24178
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(BufferEffect[24178], self.caster, target, nil, 24136)
	end
end
-- 创建时
function Buffer24118:OnCreate(caster, target)
	-- 24178
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(BufferEffect[24178], self.caster, target, nil, 24136)
	end
end
