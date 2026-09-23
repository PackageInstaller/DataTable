-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer103310105 = oo.class(BuffBase)
function Buffer103310105:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer103310105:OnCreate(caster, target)
	-- 103310105
	self:AddAttrPercent(BufferEffect[103310105], self.caster, target or self.owner, nil,"defense",-0.3)
end
