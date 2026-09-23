-- 機動弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5206 = oo.class(BuffBase)
function Buffer5206:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5206:OnCreate(caster, target)
	-- 5206
	self:AddAttr(BufferEffect[5206], self.caster, target or self.owner, nil,"speed",-30)
end
