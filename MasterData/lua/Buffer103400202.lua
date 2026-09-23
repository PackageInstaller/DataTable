-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer103400202 = oo.class(BuffBase)
function Buffer103400202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer103400202:OnCreate(caster, target)
	-- 103400202
	self:AddAttrPercent(BufferEffect[103400202], self.caster, self.card, nil, "defense",-0.08)
end
