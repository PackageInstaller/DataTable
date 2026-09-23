-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24125 = oo.class(BuffBase)
function Buffer24125:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer24125:OnCreate(caster, target)
	-- 24122
	self:AddAttr(BufferEffect[24122], self.caster, self.card, nil, "bedamage",-0.09)
	-- 24125
	self:AddAttr(BufferEffect[24125], self.caster, self.card, nil, "damage",0.02)
end
