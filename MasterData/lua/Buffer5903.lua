-- 易傷
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5903 = oo.class(BuffBase)
function Buffer5903:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5903:OnCreate(caster, target)
	-- 5903
	self:AddAttr(BufferEffect[5903], self.caster, target or self.owner, nil,"bedamage",0.15)
end
