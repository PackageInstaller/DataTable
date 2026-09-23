-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer337003 = oo.class(BuffBase)
function Buffer337003:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer337003:OnCreate(caster, target)
	-- 4203
	self:AddAttr(BufferEffect[4203], self.caster, target or self.owner, nil,"speed",15)
end
