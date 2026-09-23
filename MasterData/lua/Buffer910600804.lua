-- T-力場
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer910600804 = oo.class(BuffBase)
function Buffer910600804:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer910600804:OnCreate(caster, target)
	-- 2157
	self:AddShield(BufferEffect[2157], self.caster, target or self.owner, nil,3,50)
	-- 910600802
	self:AddAttr(BufferEffect[910600802], self.caster, self.card, nil, "speed",50)
end
