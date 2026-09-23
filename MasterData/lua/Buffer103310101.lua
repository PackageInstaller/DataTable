-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer103310101 = oo.class(BuffBase)
function Buffer103310101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer103310101:OnCreate(caster, target)
	-- 103310101
	self:AddAttrPercent(BufferEffect[103310101], self.caster, target or self.owner, nil,"defense",-0.2)
end
