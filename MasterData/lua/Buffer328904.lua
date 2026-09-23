-- 遺禍
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer328904 = oo.class(BuffBase)
function Buffer328904:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer328904:OnCreate(caster, target)
	-- 328904
	self:AddAttrPercent(BufferEffect[328904], self.caster, self.card, nil, "attack",0.08*self.nCount)
end
