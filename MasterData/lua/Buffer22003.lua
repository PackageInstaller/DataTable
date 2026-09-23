-- 防禦和抵抗提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer22003 = oo.class(BuffBase)
function Buffer22003:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer22003:OnCreate(caster, target)
	-- 22003
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 1)
	for i,target in ipairs(targets) do
		self:AddAttr(BufferEffect[22003], self.caster, target, nil, "resist",0.15)
	end
	-- 22013
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 1)
	for i,target in ipairs(targets) do
		self:AddAttrPercent(BufferEffect[22013], self.caster, target, nil, "defense",0.15)
	end
end
