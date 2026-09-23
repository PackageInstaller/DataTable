-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer336203 = oo.class(BuffBase)
function Buffer336203:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer336203:OnCreate(caster, target)
	-- 336203
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddMaxHpPercent(BufferEffect[336203], self.caster, target, nil, 0.09)
	end
	-- 336213
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddAttrPercent(BufferEffect[336213], self.caster, target, nil, "defense",0.09)
	end
end
