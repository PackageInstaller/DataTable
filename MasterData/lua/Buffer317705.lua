-- 傷害強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer317705 = oo.class(BuffBase)
function Buffer317705:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer317705:OnCreate(caster, target)
	-- 317705
	self:AddAttr(BufferEffect[317705], self.caster, target or self.owner, nil,"damage",0.15)
end
