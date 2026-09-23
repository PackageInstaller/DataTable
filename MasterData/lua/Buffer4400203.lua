-- 包銷
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4400203 = oo.class(BuffBase)
function Buffer4400203:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4400203:OnCreate(caster, target)
	-- 4400202
	self:AddAttr(BufferEffect[4400202], self.caster, target or self.owner, nil,"speed",10*self.nCount)
end
