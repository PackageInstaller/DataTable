-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200201320 = oo.class(BuffBase)
function Buffer200201320:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer200201320:OnCreate(caster, target)
	self:AddAttr(BufferEffect[200201320], self.caster, target or self.owner, nil,"crit",0.80)
end
