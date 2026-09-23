-- 迅捷：妨礙
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010131 = oo.class(BuffBase)
function Buffer1000010131:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000010131:OnCreate(caster, target)
	-- 1000010131
	self:AddAttrPercent(BufferEffect[1000010131], self.caster, target or self.owner, nil,"speed",-0.05)
end
