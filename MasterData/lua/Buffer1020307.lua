-- 攻擊強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1020307 = oo.class(BuffBase)
function Buffer1020307:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1020307:OnCreate(caster, target)
	-- 1020307
	self:AddAttrPercent(BufferEffect[1020307], self.caster, target or self.owner, nil,"attack",0.32)
end
