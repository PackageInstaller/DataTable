-- 前奏
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4200303 = oo.class(BuffBase)
function Buffer4200303:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4200303:OnCreate(caster, target)
	-- 4200303
	self:AddAttr(BufferEffect[4200303], self.caster, target or self.owner, nil,"resist",0.03*self.nCount)
end
