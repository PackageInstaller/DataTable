-- 災厄盔甲
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer941700601 = oo.class(BuffBase)
function Buffer941700601:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer941700601:OnCreate(caster, target)
	-- 941700601
	self:AddAttr(BufferEffect[941700601], self.caster, self.card, nil, "bedamage",-0.08*self.nCount)
	-- 941700602
	self:AddAttr(BufferEffect[941700602], self.caster, self.card, nil, "resist",0.08*self.nCount)
end
