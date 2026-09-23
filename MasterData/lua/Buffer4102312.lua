-- 攻擊降低
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4102312 = oo.class(BuffBase)
function Buffer4102312:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4102312:OnCreate(caster, target)
	-- 4102312
	self:AddAttrPercent(BufferEffect[4102312], self.caster, target or self.owner, nil,"attack",-0.15)
end
