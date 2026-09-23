-- 傷害降低
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer922500401 = oo.class(BuffBase)
function Buffer922500401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer922500401:OnCreate(caster, target)
	-- 4904
	self:AddAttr(BufferEffect[4904], self.caster, target or self.owner, nil,"bedamage",-0.2)
end
