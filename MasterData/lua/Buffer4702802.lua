-- 減傷
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4702802 = oo.class(BuffBase)
function Buffer4702802:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4702802:OnCreate(caster, target)
	-- 4903
	self:AddAttr(BufferEffect[4903], self.caster, target or self.owner, nil,"bedamage",-0.15)
end
