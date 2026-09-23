-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4103306 = oo.class(BuffBase)
function Buffer4103306:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4103306:OnCreate(caster, target)
	-- 4103306
	self:AddAttr(BufferEffect[4103306], self.caster, self.card, nil, "bedamage",0.01*self.nCount)
end
