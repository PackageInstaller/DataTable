-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer340704 = oo.class(BuffBase)
function Buffer340704:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer340704:OnCreate(caster, target)
	-- 340704
	self:AddAttrPercent(BufferEffect[340704], self.caster, self.card, nil, "defense",0.08)
end
