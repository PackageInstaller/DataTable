-- 普攻追擊
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100010330 = oo.class(BuffBase)
function Buffer1100010330:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100010330:OnCreate(caster, target)
	-- 1100010330
	self:AddAttrPercent(BufferEffect[1100010330], self.caster, self.card, nil, "attack",0.12)
end
