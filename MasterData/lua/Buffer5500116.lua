-- 持續傷害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5500116 = oo.class(BuffBase)
function Buffer5500116:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5500116:OnCreate(caster, target)
	-- 4017
	self:AddAttr(BufferEffect[4017], self.caster, target or self.owner, nil,"attack",2000)
	-- 4117
	self:AddAttr(BufferEffect[4117], self.caster, target or self.owner, nil,"defense",200)
end
