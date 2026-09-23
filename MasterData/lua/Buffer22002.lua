-- 防禦和抵抗提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer22002 = oo.class(BuffBase)
function Buffer22002:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer22002:OnCreate(caster, target)
	-- 22002
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 1)
	for i,target in ipairs(targets) do
		self:AddAttr(BufferEffect[22002], self.caster, target, nil, "resist",0.10)
	end
	-- 22012
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 1)
	for i,target in ipairs(targets) do
		self:AddAttrPercent(BufferEffect[22012], self.caster, target, nil, "defense",0.10)
	end
end
