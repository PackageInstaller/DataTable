-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24129 = oo.class(BuffBase)
function Buffer24129:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer24129:OnCreate(caster, target)
	-- 24135
	self:AddAttr(BufferEffect[24135], self.caster, self.card, nil, "bedamage",-0.12)
	-- 24138
	self:AddAttr(BufferEffect[24138], self.caster, self.card, nil, "damage",0.06)
end
