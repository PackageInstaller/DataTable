-- 攻擊強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4010 = oo.class(BuffBase)
function Buffer4010:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4010:OnCreate(caster, target)
	-- 4010
	self:AddAttrPercent(BufferEffect[4010], self.caster, target or self.owner, nil,"attack",0.50)
end
