-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24131 = oo.class(BuffBase)
function Buffer24131:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer24131:OnCreate(caster, target)
	-- 24146
	self:AddAttr(BufferEffect[24146], self.caster, self.card, nil, "bedamage",-0.03)
	-- 24149
	self:AddAttr(BufferEffect[24149], self.caster, self.card, nil, "damage",0.04)
end
