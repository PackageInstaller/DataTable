-- 攻擊弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5001 = oo.class(BuffBase)
function Buffer5001:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5001:OnCreate(caster, target)
	-- 5001
	self:AddAttrPercent(BufferEffect[5001], self.caster, target or self.owner, nil,"attack",-0.05)
end
