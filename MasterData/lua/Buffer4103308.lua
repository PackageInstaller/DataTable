-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4103308 = oo.class(BuffBase)
function Buffer4103308:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4103308:OnCreate(caster, target)
	-- 4103308
	self:AddAttr(BufferEffect[4103308], self.caster, self.card, nil, "bedamage",0.03*self.nCount)
end
