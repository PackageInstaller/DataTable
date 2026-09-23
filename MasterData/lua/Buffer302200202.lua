-- 減傷
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer302200202 = oo.class(BuffBase)
function Buffer302200202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer302200202:OnCreate(caster, target)
	-- 4902
	self:AddAttr(BufferEffect[4902], self.caster, target or self.owner, nil,"bedamage",-0.1)
end
