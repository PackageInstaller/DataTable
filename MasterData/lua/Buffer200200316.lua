-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200200316 = oo.class(BuffBase)
function Buffer200200316:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer200200316:OnCreate(caster, target)
	self:AddAttr(BufferEffect[200200316], self.caster, target or self.owner, nil,"crit",0.28)
end
