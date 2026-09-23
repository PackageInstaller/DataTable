-- 普攻追擊
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100010082 = oo.class(BuffBase)
function Buffer1100010082:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100010082:OnCreate(caster, target)
	-- 1100010083
	self:AddShield(BufferEffect[1100010083], self.caster, self.card, nil, 6,0.2)
	-- 1100010086
	self:AddAttrPercent(BufferEffect[1100010086], self.caster, self.card, nil, "attack",0.5)
end
