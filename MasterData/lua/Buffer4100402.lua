-- 堅韌
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4100402 = oo.class(BuffBase)
function Buffer4100402:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4100402:OnCreate(caster, target)
	-- 4100402
	self:AddAttr(BufferEffect[4100402], self.caster, target or self.owner, nil,"resist",0.15)
end
