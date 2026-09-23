-- 攻擊弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5005 = oo.class(BuffBase)
function Buffer5005:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5005:OnCreate(caster, target)
	-- 5005
	self:AddAttrPercent(BufferEffect[5005], self.caster, target or self.owner, nil,"attack",-0.25)
end
