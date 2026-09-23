-- 攻擊強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4006 = oo.class(BuffBase)
function Buffer4006:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4006:OnCreate(caster, target)
	-- 4006
	self:AddAttrPercent(BufferEffect[4006], self.caster, target or self.owner, nil,"attack",0.3)
end
