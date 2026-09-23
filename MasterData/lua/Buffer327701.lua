-- 極速應對
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer327701 = oo.class(BuffBase)
function Buffer327701:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer327701:OnCreate(caster, target)
	-- 327701
	self:AddAttr(BufferEffect[327701], self.caster, target or self.owner, nil,"speed",10)
end
