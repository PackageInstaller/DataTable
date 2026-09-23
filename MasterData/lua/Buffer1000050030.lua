-- 我方全體速度+16%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000050030 = oo.class(BuffBase)
function Buffer1000050030:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000050030:OnCreate(caster, target)
	-- 1000050030
	self:AddAttrPercent(BufferEffect[1000050030], self.caster, self.card, nil, "speed",0.32)
end
