-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer103400242 = oo.class(BuffBase)
function Buffer103400242:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer103400242:OnCreate(caster, target)
	-- 103400226
	self:AddAttrPercent(BufferEffect[103400226], self.caster, self.card, nil, "defense",-0.2)
end
