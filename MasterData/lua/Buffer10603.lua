-- 抵抗強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10603 = oo.class(BuffBase)
function Buffer10603:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10603:OnCreate(caster, target)
	-- 4603
	self:AddAttr(BufferEffect[4603], self.caster, target or self.owner, nil,"resist",0.15)
end
