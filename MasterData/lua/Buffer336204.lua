-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer336204 = oo.class(BuffBase)
function Buffer336204:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer336204:OnCreate(caster, target)
	-- 336204
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddMaxHpPercent(BufferEffect[336204], self.caster, target, nil, 0.12)
	end
	-- 336214
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddAttrPercent(BufferEffect[336214], self.caster, target, nil, "defense",0.12)
	end
end
