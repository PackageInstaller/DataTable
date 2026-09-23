-- 機動強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4301205 = oo.class(BuffBase)
function Buffer4301205:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4301205:OnCreate(caster, target)
	-- 4301205
	self:AddAttr(BufferEffect[4301205], self.caster, target or self.owner, nil,"speed",10*self.nCount)
end
