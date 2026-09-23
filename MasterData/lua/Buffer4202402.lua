-- 風笛
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4202402 = oo.class(BuffBase)
function Buffer4202402:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4202402:OnCreate(caster, target)
	-- 4202402
	self:AddAttr(BufferEffect[4202402], self.caster, self.card, nil, "bedamage",-0.04*self.nCount)
end
