-- 防禦強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer922900201 = oo.class(BuffBase)
function Buffer922900201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer922900201:OnCreate(caster, target)
	-- 922900201
	self:AddAttrPercent(BufferEffect[922900201], self.caster, target or self.owner, nil,"defense",0.5)
end
