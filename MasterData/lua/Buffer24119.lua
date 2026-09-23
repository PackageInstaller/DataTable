-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24119 = oo.class(BuffBase)
function Buffer24119:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer24119:OnCreate(caster, target)
	-- 24101
	self:AddAttr(BufferEffect[24101], self.caster, self.card, nil, "bedamage",-0.15)
end
