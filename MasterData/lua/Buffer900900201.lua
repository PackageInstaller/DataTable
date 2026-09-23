-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer900900201 = oo.class(BuffBase)
function Buffer900900201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer900900201:OnCreate(caster, target)
	self:AddAttr(BufferEffect[4202], self.caster, target or self.owner, nil,"speed",10)
end
