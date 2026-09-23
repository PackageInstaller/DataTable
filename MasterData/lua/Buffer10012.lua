-- 機神強化-等級3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10012 = oo.class(BuffBase)
function Buffer10012:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10012:OnCreate(caster, target)
	-- 4021
	self:AddAttrPercent(BufferEffect[4021], self.caster, target or self.owner, nil,"attack",0.15)
end
