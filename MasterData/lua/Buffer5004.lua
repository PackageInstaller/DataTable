-- 攻擊弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5004 = oo.class(BuffBase)
function Buffer5004:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5004:OnCreate(caster, target)
	-- 5004
	self:AddAttrPercent(BufferEffect[5004], self.caster, target or self.owner, nil,"attack",-0.2)
end
