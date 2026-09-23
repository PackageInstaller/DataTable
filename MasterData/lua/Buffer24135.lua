-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24135 = oo.class(BuffBase)
function Buffer24135:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer24135:OnCreate(caster, target)
	-- 24159
	self:AddAttr(BufferEffect[24159], self.caster, self.card, nil, "damage",0.1)
end
