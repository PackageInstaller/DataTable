-- 武裝升級
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4403901 = oo.class(BuffBase)
function Buffer4403901:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4403901:OnCreate(caster, target)
	-- 4403901
	self:AddAttr(BufferEffect[4403901], self.caster, target or self.owner, nil,"attack",100*self.nCount)
	-- 4403902
	self:AddAttr(BufferEffect[4403902], self.caster, target or self.owner, nil,"speed",1*self.nCount)
end
