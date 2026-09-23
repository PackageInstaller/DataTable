-- 守護之心
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer910800502 = oo.class(BuffBase)
function Buffer910800502:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer910800502:OnCreate(caster, target)
	-- 910800501
	self:AddAttrPercent(BufferEffect[910800501], self.caster, target or self.owner, nil,"attack",0.1*self.nCount)
	-- 910800502
	self:AddAttrPercent(BufferEffect[910800502], self.caster, target or self.owner, nil,"defense",0.1*self.nCount)
	-- 910800503
	self:AddAttr(BufferEffect[910800503], self.caster, target or self.owner, nil,"speed",10*self.nCount)
end
