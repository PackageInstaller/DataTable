-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6300005 = oo.class(BuffBase)
function Buffer6300005:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer6300005:OnCreate(caster, target)
	-- 4609
	self:AddAttr(BufferEffect[4609], self.caster, target or self.owner, nil,"resist",0.5)
end
