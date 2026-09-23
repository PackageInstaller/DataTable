-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer340714 = oo.class(BuffBase)
function Buffer340714:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer340714:OnCreate(caster, target)
	-- 340710
	self:AddAttrPercent(BufferEffect[340710], self.caster, self.card, nil, "defense",0.16)
end
