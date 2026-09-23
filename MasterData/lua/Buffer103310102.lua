-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer103310102 = oo.class(BuffBase)
function Buffer103310102:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer103310102:OnCreate(caster, target)
	-- 103310102
	self:AddAttrPercent(BufferEffect[103310102], self.caster, target or self.owner, nil,"defense",-0.2)
end
