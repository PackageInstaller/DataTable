-- 抵抗強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10605 = oo.class(BuffBase)
function Buffer10605:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10605:OnCreate(caster, target)
	-- 4605
	self:AddAttr(BufferEffect[4605], self.caster, target or self.owner, nil,"resist",0.25)
end
