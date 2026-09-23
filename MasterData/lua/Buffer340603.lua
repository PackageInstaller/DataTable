-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer340603 = oo.class(BuffBase)
function Buffer340603:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer340603:OnCreate(caster, target)
	-- 340603
	self:AddAttrPercent(BufferEffect[340603], self.caster, self.card, nil, "attack",0.3)
	-- 340608
	self:AddAttr(BufferEffect[340608], self.caster, self.card, nil, "bedamage",0.6)
	-- 340613
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddAttr(BufferEffect[340613], self.caster, target, nil, "bedamage",-0.3)
	end
end
