-- 穿透傷害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer23902 = oo.class(BuffBase)
function Buffer23902:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer23902:OnCreate(caster, target)
	-- 23902
	self:LimitDamage(BufferEffect[23902], self.caster, target or self.owner, nil,1,0.3)
end
