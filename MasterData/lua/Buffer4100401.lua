-- 堅韌
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4100401 = oo.class(BuffBase)
function Buffer4100401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4100401:OnCreate(caster, target)
	-- 4100401
	self:AddAttr(BufferEffect[4100401], self.caster, target or self.owner, nil,"resist",0.10)
end
