-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer340742 = oo.class(BuffBase)
function Buffer340742:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer340742:OnCreate(caster, target)
	-- 340726
	self:AddAttrPercent(BufferEffect[340726], self.caster, self.card, nil, "defense",0.20)
end
