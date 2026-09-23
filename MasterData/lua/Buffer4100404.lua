-- 堅韌
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4100404 = oo.class(BuffBase)
function Buffer4100404:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4100404:OnCreate(caster, target)
	-- 4100404
	self:AddAttr(BufferEffect[4100404], self.caster, target or self.owner, nil,"resist",0.25)
end
