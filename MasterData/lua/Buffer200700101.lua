-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200700101 = oo.class(BuffBase)
function Buffer200700101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer200700101:OnCreate(caster, target)
	self:AddNp(BufferEffect[201400201], self.caster, target or self.owner, nil,10)
end
