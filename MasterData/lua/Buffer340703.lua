-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer340703 = oo.class(BuffBase)
function Buffer340703:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer340703:OnCreate(caster, target)
	-- 340703
	self:AddAttrPercent(BufferEffect[340703], self.caster, self.card, nil, "defense",0.06)
end
