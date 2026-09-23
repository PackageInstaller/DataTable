-- 減傷
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200800313 = oo.class(BuffBase)
function Buffer200800313:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer200800313:OnCreate(caster, target)
	-- 200800313
	self:AddAttr(BufferEffect[200800313], self.caster, self.card, nil, "bedamage",-0.10)
end
