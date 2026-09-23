-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24126 = oo.class(BuffBase)
function Buffer24126:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer24126:OnCreate(caster, target)
	-- 24123
	self:AddAttr(BufferEffect[24123], self.caster, self.card, nil, "bedamage",-0.18)
	-- 24126
	self:AddAttr(BufferEffect[24126], self.caster, self.card, nil, "damage",0.04)
end
