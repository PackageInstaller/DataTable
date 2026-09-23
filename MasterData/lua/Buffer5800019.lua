-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5800019 = oo.class(BuffBase)
function Buffer5800019:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5800019:OnCreate(caster, target)
	-- 4910
	self:AddAttr(BufferEffect[4910], self.caster, target or self.owner, nil,"damage2",0.01*self.nCount)
end
