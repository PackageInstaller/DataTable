-- 攻擊減少
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer984010802 = oo.class(BuffBase)
function Buffer984010802:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer984010802:OnCreate(caster, target)
	-- 5003
	self:AddAttrPercent(BufferEffect[5003], self.caster, target or self.owner, nil,"attack",-0.15)
end
