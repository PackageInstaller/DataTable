-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24128 = oo.class(BuffBase)
function Buffer24128:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer24128:OnCreate(caster, target)
	-- 24134
	self:AddAttr(BufferEffect[24134], self.caster, self.card, nil, "bedamage",-0.06)
	-- 24137
	self:AddAttr(BufferEffect[24137], self.caster, self.card, nil, "damage",0.03)
end
