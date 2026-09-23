-- 善念
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4603201 = oo.class(BuffBase)
function Buffer4603201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4603201:OnCreate(caster, target)
	-- 4603201
	self:AddAttr(BufferEffect[4603201], self.caster, self.card, nil, "bedamage",-0.05*self.nCount)
	-- 4603202
	self:AddAttr(BufferEffect[4603202], self.caster, self.card, nil, "resist",0.05*self.nCount)
	-- 4603203
	self:AddAttr(BufferEffect[4603203], self.caster, self.card, nil, "cure",0.05*self.nCount)
end
