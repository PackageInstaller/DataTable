-- 攻擊和命中提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer21903 = oo.class(BuffBase)
function Buffer21903:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer21903:OnCreate(caster, target)
	-- 21903
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 1)
	for i,target in ipairs(targets) do
		self:AddAttrPercent(BufferEffect[21903], self.caster, target, nil, "attack",0.15)
	end
	-- 21913
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 1)
	for i,target in ipairs(targets) do
		self:AddAttr(BufferEffect[21913], self.caster, target, nil, "hit",0.15)
	end
end
