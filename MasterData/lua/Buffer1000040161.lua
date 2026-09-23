-- 能級：群體效應
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000040161 = oo.class(BuffBase)
function Buffer1000040161:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000040161:OnCreate(caster, target)
	-- 1000040161
	self:AddAttrPercent(BufferEffect[1000040161], self.caster, self.card, nil, "attack",0.3)
end
