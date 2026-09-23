-- 防禦減少
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer984010804 = oo.class(BuffBase)
function Buffer984010804:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer984010804:OnCreate(caster, target)
	-- 5104
	self:AddAttrPercent(BufferEffect[5104], self.caster, target or self.owner, nil,"defense",-0.2)
end
