-- 持續傷害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5500113 = oo.class(BuffBase)
function Buffer5500113:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5500113:OnCreate(caster, target)
	-- 5504
	self:AddAttr(BufferEffect[5504], self.caster, target or self.owner, nil,"hit",-0.2)
	-- 5604
	self:AddAttr(BufferEffect[5604], self.caster, target or self.owner, nil,"resist",-0.2)
end
