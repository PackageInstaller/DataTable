-- 風笛
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4202401 = oo.class(BuffBase)
function Buffer4202401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4202401:OnCreate(caster, target)
	-- 4202401
	self:AddAttr(BufferEffect[4202401], self.caster, self.card, nil, "bedamage",-0.02*self.nCount)
end
