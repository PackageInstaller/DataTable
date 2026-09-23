-- 攻擊力-15%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer950200702 = oo.class(BuffBase)
function Buffer950200702:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer950200702:OnCreate(caster, target)
	-- 5003
	self:AddAttrPercent(BufferEffect[5003], self.caster, target or self.owner, nil,"attack",-0.15)
end
