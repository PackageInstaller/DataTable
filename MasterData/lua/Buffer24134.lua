-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24134 = oo.class(BuffBase)
function Buffer24134:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer24134:OnCreate(caster, target)
	-- 24158
	self:AddAttr(BufferEffect[24158], self.caster, self.card, nil, "damage",0.05)
end
