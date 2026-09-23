-- 傷害強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer318601 = oo.class(BuffBase)
function Buffer318601:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer318601:OnCreate(caster, target)
	-- 318601
	self:AddAttr(BufferEffect[318601], self.caster, target or self.owner, nil,"damage",0.05)
end
