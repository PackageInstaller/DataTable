-- 遺禍
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer328903 = oo.class(BuffBase)
function Buffer328903:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer328903:OnCreate(caster, target)
	-- 328903
	self:AddAttrPercent(BufferEffect[328903], self.caster, self.card, nil, "attack",0.07*self.nCount)
end
