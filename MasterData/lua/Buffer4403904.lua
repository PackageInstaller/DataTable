-- 武裝升級
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4403904 = oo.class(BuffBase)
function Buffer4403904:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4403904:OnCreate(caster, target)
	-- 4403907
	self:AddAttr(BufferEffect[4403907], self.caster, target or self.owner, nil,"attack",200*self.nCount)
	-- 4403908
	self:AddAttr(BufferEffect[4403908], self.caster, target or self.owner, nil,"speed",3*self.nCount)
end
