-- 機動強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer202300204 = oo.class(BuffBase)
function Buffer202300204:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer202300204:OnCreate(caster, target)
	-- 4207
	self:AddAttr(BufferEffect[4207], self.caster, target or self.owner, nil,"speed",35)
end
