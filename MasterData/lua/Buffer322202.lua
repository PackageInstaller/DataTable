-- 傷害強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer322202 = oo.class(BuffBase)
function Buffer322202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer322202:OnCreate(caster, target)
	-- 322202
	self:AddAttr(BufferEffect[322202], self.caster, target or self.owner, nil,"damage",0.08*self.nCount)
end
