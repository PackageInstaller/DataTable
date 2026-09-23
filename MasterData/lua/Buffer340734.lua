-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer340734 = oo.class(BuffBase)
function Buffer340734:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer340734:OnCreate(caster, target)
	-- 340722
	self:AddAttrPercent(BufferEffect[340722], self.caster, self.card, nil, "defense",0.32)
end
