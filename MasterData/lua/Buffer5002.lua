-- 攻擊弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5002 = oo.class(BuffBase)
function Buffer5002:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5002:OnCreate(caster, target)
	-- 5002
	self:AddAttrPercent(BufferEffect[5002], self.caster, target or self.owner, nil,"attack",-0.1)
end
