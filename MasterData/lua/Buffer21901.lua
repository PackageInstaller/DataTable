-- 攻擊和命中提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer21901 = oo.class(BuffBase)
function Buffer21901:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer21901:OnCreate(caster, target)
	-- 21901
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 1)
	for i,target in ipairs(targets) do
		self:AddAttrPercent(BufferEffect[21901], self.caster, target, nil, "attack",0.05)
	end
	-- 21911
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 1)
	for i,target in ipairs(targets) do
		self:AddAttr(BufferEffect[21911], self.caster, target, nil, "hit",0.05)
	end
end
