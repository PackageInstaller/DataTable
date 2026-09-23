-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5304306 = oo.class(BuffBase)
function Buffer5304306:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5304306:OnCreate(caster, target)
	-- 5304311
	self:AddAttr(BufferEffect[5304311], self.caster, self.card, nil, "attack",100*self.nCount)
end
