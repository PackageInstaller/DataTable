-- 機動強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10202 = oo.class(BuffBase)
function Buffer10202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10202:OnCreate(caster, target)
	-- 4202
	self:AddAttr(BufferEffect[4202], self.caster, target or self.owner, nil,"speed",10)
end
