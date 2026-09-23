-- 攻擊強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200200202 = oo.class(BuffBase)
function Buffer200200202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer200200202:OnCreate(caster, target)
	-- 200200202
	self:AddAttrPercent(BufferEffect[200200202], self.caster, target or self.owner, nil,"attack",0.19)
end
