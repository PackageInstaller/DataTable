-- 釣魚佬
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer912100101 = oo.class(BuffBase)
function Buffer912100101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer912100101:OnCreate(caster, target)
	-- 4906
	self:AddAttr(BufferEffect[4906], self.caster, target or self.owner, nil,"bedamage",-0.3)
end
