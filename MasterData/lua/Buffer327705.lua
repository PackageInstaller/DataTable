-- 極速應對
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer327705 = oo.class(BuffBase)
function Buffer327705:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer327705:OnCreate(caster, target)
	-- 327705
	self:AddAttr(BufferEffect[327705], self.caster, target or self.owner, nil,"speed",50)
end
