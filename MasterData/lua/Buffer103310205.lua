-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer103310205 = oo.class(BuffBase)
function Buffer103310205:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer103310205:OnCreate(caster, target)
	-- 103310205
	self:AddAttr(BufferEffect[103310205], self.caster, target or self.owner, nil,"crit",-0.5)
end
