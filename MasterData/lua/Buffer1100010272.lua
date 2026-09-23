-- 普攻追擊
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100010272 = oo.class(BuffBase)
function Buffer1100010272:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100010272:OnCreate(caster, target)
	-- 23403
	self:AddAttr(BufferEffect[23403], self.caster, self.card, nil, "speed",30)
	-- 23413
	self:AddAttr(BufferEffect[23413], self.caster, self.card, nil, "hit",0.3)
	-- 23423
	self:AddSp(BufferEffect[23423], self.caster, self.card, nil, 30)
end
