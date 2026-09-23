-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24127 = oo.class(BuffBase)
function Buffer24127:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer24127:OnCreate(caster, target)
	-- 24124
	self:AddAttr(BufferEffect[24124], self.caster, self.card, nil, "bedamage",-0.27)
	-- 24127
	self:AddAttr(BufferEffect[24127], self.caster, self.card, nil, "damage",0.06)
end
