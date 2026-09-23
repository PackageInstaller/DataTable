-- 全體退條
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4302703 = oo.class(BuffBase)
function Buffer4302703:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4302703:OnCreate(caster, target)
	-- 4302703
	self:AddAttr(BufferEffect[4302703], self.caster, target or self.owner, nil,"crit_rate",-0.12)
end
