-- 心智擾亂
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer337602 = oo.class(BuffBase)
function Buffer337602:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer337602:OnCreate(caster, target)
	-- 337602
	self:LimitDamage(BufferEffect[337602], self.caster, target or self.owner, nil,1,0.60)
end
