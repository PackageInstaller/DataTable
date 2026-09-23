-- 劍鏡
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4600201 = oo.class(BuffBase)
function Buffer4600201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4600201:OnCreate(caster, target)
	-- 4302
	self:AddAttr(BufferEffect[4302], self.caster, target or self.owner, nil,"crit_rate",0.1)
end
