-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer340741 = oo.class(BuffBase)
function Buffer340741:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer340741:OnCreate(caster, target)
	-- 340725
	self:AddAttrPercent(BufferEffect[340725], self.caster, self.card, nil, "defense",0.10)
end
