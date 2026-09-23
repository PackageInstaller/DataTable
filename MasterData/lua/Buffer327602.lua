-- 極速抵禦
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer327602 = oo.class(BuffBase)
function Buffer327602:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer327602:OnCreate(caster, target)
	-- 327602
	self:AddAttr(BufferEffect[327602], self.caster, target or self.owner, nil,"bedamage",-0.2)
	-- 327612
	self:AddAttr(BufferEffect[327612], self.caster, target or self.owner, nil,"resist",0.2)
end
