-- 防禦強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer315104 = oo.class(BuffBase)
function Buffer315104:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer315104:OnCreate(caster, target)
	-- 315104
	self:AddAttrPercent(BufferEffect[315104], self.caster, target or self.owner, nil,"defense",0.08)
end
