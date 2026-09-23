-- 極速抵禦
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer327603 = oo.class(BuffBase)
function Buffer327603:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer327603:OnCreate(caster, target)
	-- 327603
	self:AddAttr(BufferEffect[327603], self.caster, target or self.owner, nil,"bedamage",-0.3)
	-- 327613
	self:AddAttr(BufferEffect[327613], self.caster, target or self.owner, nil,"resist",0.3)
end
