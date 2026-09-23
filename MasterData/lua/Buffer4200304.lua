-- 前奏
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4200304 = oo.class(BuffBase)
function Buffer4200304:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4200304:OnCreate(caster, target)
	-- 4200304
	self:AddAttr(BufferEffect[4200304], self.caster, target or self.owner, nil,"resist",0.04*self.nCount)
end
