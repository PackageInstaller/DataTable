-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24124 = oo.class(BuffBase)
function Buffer24124:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer24124:OnCreate(caster, target)
	-- 24112
	self:AddAttr(BufferEffect[24112], self.caster, self.card, nil, "bedamage",-0.36)
	-- 24115
	self:AddAttr(BufferEffect[24115], self.caster, self.card, nil, "damage",0.03)
end
