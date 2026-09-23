-- 防禦強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer315101 = oo.class(BuffBase)
function Buffer315101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer315101:OnCreate(caster, target)
	-- 315101
	self:AddAttrPercent(BufferEffect[315101], self.caster, target or self.owner, nil,"defense",0.02)
end
