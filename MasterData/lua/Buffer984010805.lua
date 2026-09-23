-- 造成傷害減少
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer984010805 = oo.class(BuffBase)
function Buffer984010805:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer984010805:OnCreate(caster, target)
	-- 5804
	self:AddAttr(BufferEffect[5804], self.caster, target or self.owner, nil,"damage",-0.2)
end
