-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24120 = oo.class(BuffBase)
function Buffer24120:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer24120:OnCreate(caster, target)
	-- 24102
	self:AddAttr(BufferEffect[24102], self.caster, self.card, nil, "bedamage",-0.3)
end
