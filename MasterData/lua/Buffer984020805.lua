-- 造成傷害增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer984020805 = oo.class(BuffBase)
function Buffer984020805:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer984020805:OnCreate(caster, target)
	-- 4804
	self:AddAttr(BufferEffect[4804], self.caster, target or self.owner, nil,"damage",0.2)
end
