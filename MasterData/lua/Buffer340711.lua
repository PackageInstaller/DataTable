-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer340711 = oo.class(BuffBase)
function Buffer340711:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer340711:OnCreate(caster, target)
	-- 340707
	self:AddAttrPercent(BufferEffect[340707], self.caster, self.card, nil, "defense",0.04)
end
