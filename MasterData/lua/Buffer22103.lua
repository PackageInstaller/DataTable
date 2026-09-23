-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer22103 = oo.class(BuffBase)
function Buffer22103:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer22103:OnCreate(caster, target)
	-- 22103
	self:AddAttr(BufferEffect[22103], self.caster, self.card, nil, "careerAdjust",0.45)
end
