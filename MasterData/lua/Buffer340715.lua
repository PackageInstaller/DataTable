-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer340715 = oo.class(BuffBase)
function Buffer340715:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer340715:OnCreate(caster, target)
	-- 340711
	self:AddAttrPercent(BufferEffect[340711], self.caster, self.card, nil, "defense",0.20)
end
