-- 抵抗強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer9021 = oo.class(BuffBase)
function Buffer9021:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer9021:OnCreate(caster, target)
	-- 4606
	self:AddAttr(BufferEffect[4606], self.caster, target or self.owner, nil,"resist",0.3)
end
