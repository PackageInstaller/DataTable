-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200200308 = oo.class(BuffBase)
function Buffer200200308:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer200200308:OnCreate(caster, target)
	self:AddAttr(BufferEffect[200200308], self.caster, target or self.owner, nil,"crit_rate",0.25)
end
