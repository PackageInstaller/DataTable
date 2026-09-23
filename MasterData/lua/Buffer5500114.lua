-- 持續傷害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5500114 = oo.class(BuffBase)
function Buffer5500114:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5500114:OnCreate(caster, target)
	-- 5506
	self:AddAttr(BufferEffect[5506], self.caster, target or self.owner, nil,"hit",-0.3)
	-- 5606
	self:AddAttr(BufferEffect[5606], self.caster, target or self.owner, nil,"resist",-0.3)
end
