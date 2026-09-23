-- 命中強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4502513 = oo.class(BuffBase)
function Buffer4502513:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4502513:OnCreate(caster, target)
	-- 4502513
	self:AddAttrPercent(BufferEffect[4502513], self.caster, target or self.owner, nil,"attack",0.04)
end
