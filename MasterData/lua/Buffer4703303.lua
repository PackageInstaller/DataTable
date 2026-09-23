-- 攻擊提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4703303 = oo.class(BuffBase)
function Buffer4703303:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4703303:OnCreate(caster, target)
	-- 4006
	self:AddAttrPercent(BufferEffect[4006], self.caster, target or self.owner, nil,"attack",0.3)
end
