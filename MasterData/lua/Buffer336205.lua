-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer336205 = oo.class(BuffBase)
function Buffer336205:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer336205:OnCreate(caster, target)
	-- 336205
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddMaxHpPercent(BufferEffect[336205], self.caster, target, nil, 0.15)
	end
	-- 336215
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddAttrPercent(BufferEffect[336215], self.caster, target, nil, "defense",0.15)
	end
end
