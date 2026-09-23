-- 武裝升級
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4403903 = oo.class(BuffBase)
function Buffer4403903:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4403903:OnCreate(caster, target)
	-- 4403905
	self:AddAttr(BufferEffect[4403905], self.caster, target or self.owner, nil,"attack",150*self.nCount)
	-- 4403906
	self:AddAttr(BufferEffect[4403906], self.caster, target or self.owner, nil,"speed",2*self.nCount)
end
