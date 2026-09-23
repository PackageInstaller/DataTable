-- 極速抵禦
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer327604 = oo.class(BuffBase)
function Buffer327604:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer327604:OnCreate(caster, target)
	-- 327604
	self:AddAttr(BufferEffect[327604], self.caster, target or self.owner, nil,"bedamage",-0.4)
	-- 327614
	self:AddAttr(BufferEffect[327614], self.caster, target or self.owner, nil,"resist",0.4)
end
