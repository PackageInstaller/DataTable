-- 極速抵禦
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer327601 = oo.class(BuffBase)
function Buffer327601:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer327601:OnCreate(caster, target)
	-- 327601
	self:AddAttr(BufferEffect[327601], self.caster, target or self.owner, nil,"bedamage",-0.1)
	-- 327611
	self:AddAttr(BufferEffect[327611], self.caster, target or self.owner, nil,"resist",0.1)
end
