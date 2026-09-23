-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer103400235 = oo.class(BuffBase)
function Buffer103400235:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer103400235:OnCreate(caster, target)
	-- 103400223
	self:AddAttrPercent(BufferEffect[103400223], self.caster, self.card, nil, "defense",-0.35)
end
