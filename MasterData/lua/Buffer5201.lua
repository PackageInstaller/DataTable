-- 機動弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5201 = oo.class(BuffBase)
function Buffer5201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5201:OnCreate(caster, target)
	-- 5201
	self:AddAttr(BufferEffect[5201], self.caster, target or self.owner, nil,"speed",-5)
end
