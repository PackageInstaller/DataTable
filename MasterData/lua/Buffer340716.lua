-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer340716 = oo.class(BuffBase)
function Buffer340716:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer340716:OnCreate(caster, target)
	-- 340712
	self:AddAttrPercent(BufferEffect[340712], self.caster, self.card, nil, "defense",0.24)
end
