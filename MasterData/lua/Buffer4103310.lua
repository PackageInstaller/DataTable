-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4103310 = oo.class(BuffBase)
function Buffer4103310:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4103310:OnCreate(caster, target)
	-- 4103310
	self:AddAttr(BufferEffect[4103310], self.caster, self.card, nil, "bedamage",0.05*self.nCount)
end
