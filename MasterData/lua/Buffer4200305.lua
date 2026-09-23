-- 前奏
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4200305 = oo.class(BuffBase)
function Buffer4200305:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4200305:OnCreate(caster, target)
	-- 4200305
	self:AddAttr(BufferEffect[4200305], self.caster, target or self.owner, nil,"resist",0.05*self.nCount)
end
