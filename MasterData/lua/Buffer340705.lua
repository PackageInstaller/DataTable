-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer340705 = oo.class(BuffBase)
function Buffer340705:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer340705:OnCreate(caster, target)
	-- 340705
	self:AddAttrPercent(BufferEffect[340705], self.caster, self.card, nil, "defense",0.10)
end
