-- 堅石護盾（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer101101305 = oo.class(BuffBase)
function Buffer101101305:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer101101305:OnCreate(caster, target)
	-- 2810
	self:AddShield(BufferEffect[2810], self.caster, target or self.owner, nil,10,10)
end
