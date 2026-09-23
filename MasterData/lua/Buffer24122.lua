-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24122 = oo.class(BuffBase)
function Buffer24122:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer24122:OnCreate(caster, target)
	-- 24110
	self:AddAttr(BufferEffect[24110], self.caster, self.card, nil, "bedamage",-0.12)
	-- 24113
	self:AddAttr(BufferEffect[24113], self.caster, self.card, nil, "damage",0.01)
end
