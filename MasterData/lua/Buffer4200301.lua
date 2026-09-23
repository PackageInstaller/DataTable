-- 前奏
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4200301 = oo.class(BuffBase)
function Buffer4200301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4200301:OnCreate(caster, target)
	-- 4200301
	self:AddAttr(BufferEffect[4200301], self.caster, target or self.owner, nil,"resist",0.01*self.nCount)
end
