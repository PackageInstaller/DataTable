-- 狂暴狀態
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4906101 = oo.class(BuffBase)
function Buffer4906101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4906101:OnCreate(caster, target)
	-- 4002
	self:AddAttrPercent(BufferEffect[4002], self.caster, target or self.owner, nil,"attack",0.1)
	-- 4102
	self:AddAttrPercent(BufferEffect[4102], self.caster, target or self.owner, nil,"defense",0.1)
	-- 4202
	self:AddAttr(BufferEffect[4202], self.caster, target or self.owner, nil,"speed",10)
end
