-- 傷害強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer318604 = oo.class(BuffBase)
function Buffer318604:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer318604:OnCreate(caster, target)
	-- 318604
	self:AddAttr(BufferEffect[318604], self.caster, target or self.owner, nil,"damage",0.20)
end
