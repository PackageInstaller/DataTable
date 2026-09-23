-- 承傷增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer911100402 = oo.class(BuffBase)
function Buffer911100402:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer911100402:OnCreate(caster, target)
	-- 5902
	self:AddAttr(BufferEffect[5902], self.caster, target or self.owner, nil,"bedamage",0.1)
end
