-- 易傷
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer932800702 = oo.class(BuffBase)
function Buffer932800702:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer932800702:OnCreate(caster, target)
	-- 932800703
	self:AddAttr(BufferEffect[932800703], self.caster, self.card, nil, "bedamage",0.2)
	-- 932800704
	self:AddProgress(BufferEffect[932800704], self.caster, self.card, nil, -500)
end
