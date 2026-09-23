-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24121 = oo.class(BuffBase)
function Buffer24121:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer24121:OnCreate(caster, target)
	-- 24103
	self:AddAttr(BufferEffect[24103], self.caster, self.card, nil, "bedamage",-0.45)
end
