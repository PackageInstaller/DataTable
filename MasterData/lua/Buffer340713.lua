-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer340713 = oo.class(BuffBase)
function Buffer340713:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer340713:OnCreate(caster, target)
	-- 340709
	self:AddAttrPercent(BufferEffect[340709], self.caster, self.card, nil, "defense",0.12)
end
