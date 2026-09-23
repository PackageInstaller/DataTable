-- 傷害強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer322204 = oo.class(BuffBase)
function Buffer322204:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer322204:OnCreate(caster, target)
	-- 322204
	self:AddAttr(BufferEffect[322204], self.caster, target or self.owner, nil,"damage",0.16*self.nCount)
end
