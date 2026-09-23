-- 減傷
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4912 = oo.class(BuffBase)
function Buffer4912:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4912:OnCreate(caster, target)
	-- 4912
	self:AddAttr(BufferEffect[4912], self.caster, target or self.owner, nil,"bedamage",-0.5)
end
