-- 抵抗強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4607 = oo.class(BuffBase)
function Buffer4607:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4607:OnCreate(caster, target)
	-- 4607
	self:AddAttr(BufferEffect[4607], self.caster, target or self.owner, nil,"resist",0.35)
end
