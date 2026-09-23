-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer340731 = oo.class(BuffBase)
function Buffer340731:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer340731:OnCreate(caster, target)
	-- 340719
	self:AddAttrPercent(BufferEffect[340719], self.caster, self.card, nil, "defense",0.08)
end
