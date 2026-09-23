-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4750305 = oo.class(BuffBase)
function Buffer4750305:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4750305:OnCreate(caster, target)
	-- 4750305
	self:AddAttr(BufferEffect[4750305], self.caster, self.card, nil, "resist",0.25)
end
