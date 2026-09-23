-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer336201 = oo.class(BuffBase)
function Buffer336201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer336201:OnCreate(caster, target)
	-- 336201
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddMaxHpPercent(BufferEffect[336201], self.caster, target, nil, 0.03)
	end
	-- 336211
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddAttrPercent(BufferEffect[336211], self.caster, target, nil, "defense",0.03)
	end
end
