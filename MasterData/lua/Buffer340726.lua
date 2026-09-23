-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer340726 = oo.class(BuffBase)
function Buffer340726:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer340726:OnCreate(caster, target)
	-- 340718
	self:AddAttrPercent(BufferEffect[340718], self.caster, self.card, nil, "defense",0.36)
end
