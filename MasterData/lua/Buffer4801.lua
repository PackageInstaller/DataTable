-- 傷害強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4801 = oo.class(BuffBase)
function Buffer4801:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4801:OnCreate(caster, target)
	-- 4801
	self:AddAttr(BufferEffect[4801], self.caster, target or self.owner, nil,"damage",0.05)
end
