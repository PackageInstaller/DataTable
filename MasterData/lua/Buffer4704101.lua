-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4704101 = oo.class(BuffBase)
function Buffer4704101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4704101:OnCreate(caster, target)
	-- 4704101
	self:AddAttr(BufferEffect[4704101], self.caster, target or self.owner, nil,"crit",0.01)
end
