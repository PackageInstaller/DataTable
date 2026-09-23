-- 電磁力場
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer400700204 = oo.class(BuffBase)
function Buffer400700204:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer400700204:OnCreate(caster, target)
	-- 400700204
	self:AddAttrPercent(BufferEffect[400700204], self.caster, target or self.owner, nil,"attack",0.35)
end
