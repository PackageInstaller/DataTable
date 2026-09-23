-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24123 = oo.class(BuffBase)
function Buffer24123:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer24123:OnCreate(caster, target)
	-- 24111
	self:AddAttr(BufferEffect[24111], self.caster, self.card, nil, "bedamage",-0.24)
	-- 24114
	self:AddAttr(BufferEffect[24114], self.caster, self.card, nil, "damage",0.02)
end
