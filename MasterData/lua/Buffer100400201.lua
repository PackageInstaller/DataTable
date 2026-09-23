-- 裝甲盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer100400201 = oo.class(BuffBase)
function Buffer100400201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer100400201:OnCreate(caster, target)
	-- 2102
	self:AddShield(BufferEffect[2102], self.caster, target or self.owner, nil,1,0.1)
end
