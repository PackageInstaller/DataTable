-- 封印
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer600500304 = oo.class(BuffBase)
function Buffer600500304:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer600500304:OnCreate(caster, target)
	-- 600500304
	self:DeleteEvent(BufferEffect[600500304], self.caster, target or self.owner, nil,nil)
end
