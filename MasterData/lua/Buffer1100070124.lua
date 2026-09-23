-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100070124 = oo.class(BuffBase)
function Buffer1100070124:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100070124:OnCreate(caster, target)
	-- 4118
	self:AddAttrPercent(BufferEffect[4118], self.caster, target or self.owner, nil,"defense",0.6)
end
