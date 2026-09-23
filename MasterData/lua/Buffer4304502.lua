-- 攻擊增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4304502 = oo.class(BuffBase)
function Buffer4304502:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4304502:OnCreate(caster, target)
	-- 4304502
	self:AddAttrPercent(BufferEffect[4304502], self.caster, self.card, nil, "attack",0.01*self.nCount)
end
