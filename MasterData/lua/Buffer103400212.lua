-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer103400212 = oo.class(BuffBase)
function Buffer103400212:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer103400212:OnCreate(caster, target)
	-- 103400208
	self:AddAttrPercent(BufferEffect[103400208], self.caster, self.card, nil, "defense",-0.08)
end
