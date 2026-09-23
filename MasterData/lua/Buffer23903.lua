-- 穿透傷害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer23903 = oo.class(BuffBase)
function Buffer23903:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer23903:OnCreate(caster, target)
	-- 23903
	self:LimitDamage(BufferEffect[23903], self.caster, target or self.owner, nil,1,0.45)
end
