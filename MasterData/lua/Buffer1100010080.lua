-- 普攻追擊
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100010080 = oo.class(BuffBase)
function Buffer1100010080:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100010080:OnCreate(caster, target)
	-- 1100010081
	self:AddShield(BufferEffect[1100010081], self.caster, self.card, nil, 6,0.1)
	-- 1100010084
	self:AddAttrPercent(BufferEffect[1100010084], self.caster, self.card, nil, "attack",0.5)
end
