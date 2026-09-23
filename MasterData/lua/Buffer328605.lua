-- 易傷
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer328605 = oo.class(BuffBase)
function Buffer328605:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer328605:OnCreate(caster, target)
	-- 328605
	self:AddAttr(BufferEffect[328605], self.caster, target or self.owner, nil,"bedamage",0.10)
end
