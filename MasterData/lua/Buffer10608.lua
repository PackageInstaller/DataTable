-- 抵抗強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10608 = oo.class(BuffBase)
function Buffer10608:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10608:OnCreate(caster, target)
	-- 4608
	self:AddAttr(BufferEffect[4608], self.caster, target or self.owner, nil,"resist",0.4)
end
