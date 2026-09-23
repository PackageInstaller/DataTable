-- 暴傷強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4402 = oo.class(BuffBase)
function Buffer4402:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4402:OnCreate(caster, target)
	-- 4402
	self:AddAttr(BufferEffect[4402], self.caster, target or self.owner, nil,"crit",0.1)
end
