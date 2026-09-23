-- 極速應對
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer327704 = oo.class(BuffBase)
function Buffer327704:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer327704:OnCreate(caster, target)
	-- 327704
	self:AddAttr(BufferEffect[327704], self.caster, target or self.owner, nil,"speed",40)
end
