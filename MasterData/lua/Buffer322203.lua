-- 傷害強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer322203 = oo.class(BuffBase)
function Buffer322203:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer322203:OnCreate(caster, target)
	-- 322203
	self:AddAttr(BufferEffect[322203], self.caster, target or self.owner, nil,"damage",0.12*self.nCount)
end
