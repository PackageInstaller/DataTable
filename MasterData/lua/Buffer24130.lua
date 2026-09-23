-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24130 = oo.class(BuffBase)
function Buffer24130:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer24130:OnCreate(caster, target)
	-- 24136
	self:AddAttr(BufferEffect[24136], self.caster, self.card, nil, "bedamage",-0.18)
	-- 24139
	self:AddAttr(BufferEffect[24139], self.caster, self.card, nil, "damage",0.09)
end
