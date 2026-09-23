-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer340736 = oo.class(BuffBase)
function Buffer340736:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer340736:OnCreate(caster, target)
	-- 340724
	self:AddAttrPercent(BufferEffect[340724], self.caster, self.card, nil, "defense",0.48)
end
