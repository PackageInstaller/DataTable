-- 迅捷：抗性
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010021 = oo.class(BuffBase)
function Buffer1000010021:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000010021:OnCreate(caster, target)
	-- 1000010021
	self:AddAttr(BufferEffect[1000010021], self.caster, self.card, nil, "resist",0.1*self.nCount)
end
