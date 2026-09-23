-- 易傷
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer328602 = oo.class(BuffBase)
function Buffer328602:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer328602:OnCreate(caster, target)
	-- 328602
	self:AddAttr(BufferEffect[328602], self.caster, target or self.owner, nil,"bedamage",0.04)
end
