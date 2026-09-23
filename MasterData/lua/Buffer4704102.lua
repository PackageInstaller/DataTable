-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4704102 = oo.class(BuffBase)
function Buffer4704102:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4704102:OnCreate(caster, target)
	-- 4704102
	self:AddAttr(BufferEffect[4704102], self.caster, target or self.owner, nil,"crit",0.02)
end
