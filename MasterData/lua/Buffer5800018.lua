-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5800018 = oo.class(BuffBase)
function Buffer5800018:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5800018:OnCreate(caster, target)
	-- 4110
	self:AddAttrPercent(BufferEffect[4110], self.caster, target or self.owner, nil,"defense",0.5)
end
