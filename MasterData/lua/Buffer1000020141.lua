-- 我方全體+20%防禦力（2級）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000020141 = oo.class(BuffBase)
function Buffer1000020141:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000020141:OnCreate(caster, target)
	-- 1000020141
	self:AddAttrPercent(BufferEffect[1000020141], self.caster, self.card, nil, "defense",0.2)
end
