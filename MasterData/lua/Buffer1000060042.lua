-- 降速：降低目標的速度，持續2回合，可疊層
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000060042 = oo.class(BuffBase)
function Buffer1000060042:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000060042:OnCreate(caster, target)
	-- 1000060042
	self:AddAttrPercent(BufferEffect[1000060042], self.caster, target or self.owner, nil,"speed",-0.08)
end
