-- 星輝
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer913800501 = oo.class(BuffBase)
function Buffer913800501:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer913800501:OnCreate(caster, target)
	-- 913800501
	self:AddAttrPercent(BufferEffect[913800501], self.caster, self.card, nil, "attack",0.01*self.nCount)
	-- 913800502
	self:AddAttrPercent(BufferEffect[913800502], self.caster, self.card, nil, "defense",0.01*self.nCount)
end
