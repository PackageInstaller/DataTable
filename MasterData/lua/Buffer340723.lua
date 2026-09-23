-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer340723 = oo.class(BuffBase)
function Buffer340723:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer340723:OnCreate(caster, target)
	-- 340715
	self:AddAttrPercent(BufferEffect[340715], self.caster, self.card, nil, "defense",0.18)
end
