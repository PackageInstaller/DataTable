-- 機動強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer910900402 = oo.class(BuffBase)
function Buffer910900402:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer910900402:OnCreate(caster, target)
	-- 910900402
	self:AddAttr(BufferEffect[910900402], self.caster, target or self.owner, nil,"speed",20*self.nCount)
end
