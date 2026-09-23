-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4102301 = oo.class(BuffBase)
function Buffer4102301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4102301:OnCreate(caster, target)
	self:SetProtect(BufferEffect[4102301], self.caster, target or self.owner, nil,10000)
end
