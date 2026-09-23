-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer103310201 = oo.class(BuffBase)
function Buffer103310201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer103310201:OnCreate(caster, target)
	-- 103310201
	self:AddAttr(BufferEffect[103310201], self.caster, target or self.owner, nil,"crit",-0.3)
end
