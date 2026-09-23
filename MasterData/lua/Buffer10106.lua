-- 防禦強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10106 = oo.class(BuffBase)
function Buffer10106:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10106:OnCreate(caster, target)
	-- 4106
	self:AddAttrPercent(BufferEffect[4106], self.caster, target or self.owner, nil,"defense",0.3)
end
