-- 減傷
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer322211 = oo.class(BuffBase)
function Buffer322211:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer322211:OnCreate(caster, target)
	-- 322211
	self:AddAttr(BufferEffect[322211], self.caster, target or self.owner, nil,"bedamage",-0.1*self.nCount)
end
