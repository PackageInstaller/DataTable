-- 包銷
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4400201 = oo.class(BuffBase)
function Buffer4400201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4400201:OnCreate(caster, target)
	-- 4400201
	self:AddAttr(BufferEffect[4400201], self.caster, target or self.owner, nil,"speed",5*self.nCount)
end
