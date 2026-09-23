-- 攻擊降低
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4102314 = oo.class(BuffBase)
function Buffer4102314:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4102314:OnCreate(caster, target)
	-- 4102314
	self:AddAttrPercent(BufferEffect[4102314], self.caster, target or self.owner, nil,"attack",-0.25)
end
