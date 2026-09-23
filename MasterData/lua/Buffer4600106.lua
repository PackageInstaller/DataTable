-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4600106 = oo.class(BuffBase)
function Buffer4600106:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4600106:OnCreate(caster, target)
	self:AddAttr(BufferEffect[4600106], self.caster, target or self.owner, nil,"crit",0.04)
end
