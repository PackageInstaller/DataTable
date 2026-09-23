-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4103305 = oo.class(BuffBase)
function Buffer4103305:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4103305:OnCreate(caster, target)
	-- 4103305
	self:AddAttr(BufferEffect[4103305], self.caster, self.card, nil, "damage",0.25*self.nCount)
end
