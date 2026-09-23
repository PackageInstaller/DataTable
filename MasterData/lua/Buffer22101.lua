-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer22101 = oo.class(BuffBase)
function Buffer22101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer22101:OnCreate(caster, target)
	-- 22101
	self:AddAttr(BufferEffect[22101], self.caster, self.card, nil, "careerAdjust",0.15)
end
