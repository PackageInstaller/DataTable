-- 機動強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4301203 = oo.class(BuffBase)
function Buffer4301203:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4301203:OnCreate(caster, target)
	-- 4301203
	self:AddAttr(BufferEffect[4301203], self.caster, target or self.owner, nil,"speed",6*self.nCount)
end
