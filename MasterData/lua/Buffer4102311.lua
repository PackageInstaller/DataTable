-- 攻擊降低
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4102311 = oo.class(BuffBase)
function Buffer4102311:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4102311:OnCreate(caster, target)
	-- 4102311
	self:AddAttrPercent(BufferEffect[4102311], self.caster, target or self.owner, nil,"attack",-0.10)
end
