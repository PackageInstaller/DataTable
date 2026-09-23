-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200201307 = oo.class(BuffBase)
function Buffer200201307:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer200201307:OnCreate(caster, target)
	self:AddAttr(BufferEffect[200201307], self.caster, target or self.owner, nil,"crit_rate",0.40)
end
