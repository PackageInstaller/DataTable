-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer340733 = oo.class(BuffBase)
function Buffer340733:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer340733:OnCreate(caster, target)
	-- 340721
	self:AddAttrPercent(BufferEffect[340721], self.caster, self.card, nil, "defense",0.24)
end
