-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer103400236 = oo.class(BuffBase)
function Buffer103400236:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer103400236:OnCreate(caster, target)
	-- 103400224
	self:AddAttrPercent(BufferEffect[103400224], self.caster, self.card, nil, "defense",-0.42)
end
