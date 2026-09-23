-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4750303 = oo.class(BuffBase)
function Buffer4750303:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4750303:OnCreate(caster, target)
	-- 4750303
	self:AddAttr(BufferEffect[4750303], self.caster, self.card, nil, "resist",0.15)
end
