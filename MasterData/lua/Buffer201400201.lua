-- 能量值+10
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer201400201 = oo.class(BuffBase)
function Buffer201400201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer201400201:OnCreate(caster, target)
	-- 201400201
	self:AddNp(BufferEffect[201400201], self.caster, target or self.owner, nil,10)
end
