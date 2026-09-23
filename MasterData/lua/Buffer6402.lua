-- 榮耀
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6402 = oo.class(BuffBase)
function Buffer6402:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer6402:OnCreate(caster, target)
	-- 4003
	self:AddAttrPercent(BufferEffect[4003], self.caster, target or self.owner, nil,"attack",0.15)
	-- 4102
	self:AddAttrPercent(BufferEffect[4102], self.caster, target or self.owner, nil,"defense",0.1)
	-- 4602
	self:AddAttr(BufferEffect[4602], self.caster, target or self.owner, nil,"resist",0.1)
end
