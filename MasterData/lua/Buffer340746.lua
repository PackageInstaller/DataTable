-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer340746 = oo.class(BuffBase)
function Buffer340746:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer340746:OnCreate(caster, target)
	-- 340730
	self:AddAttrPercent(BufferEffect[340730], self.caster, self.card, nil, "defense",0.60)
end
