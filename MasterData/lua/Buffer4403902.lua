-- 武裝升級
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4403902 = oo.class(BuffBase)
function Buffer4403902:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4403902:OnCreate(caster, target)
	-- 4403903
	self:AddAttr(BufferEffect[4403903], self.caster, target or self.owner, nil,"attack",150*self.nCount)
	-- 4403904
	self:AddAttr(BufferEffect[4403904], self.caster, target or self.owner, nil,"speed",2*self.nCount)
end
