-- 攻擊強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1020309 = oo.class(BuffBase)
function Buffer1020309:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1020309:OnCreate(caster, target)
	-- 1020309
	self:AddAttrPercent(BufferEffect[1020309], self.caster, target or self.owner, nil,"attack",0.36)
end
