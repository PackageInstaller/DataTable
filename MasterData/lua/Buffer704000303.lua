-- 綻放
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer704000303 = oo.class(BuffBase)
function Buffer704000303:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer704000303:OnCreate(caster, target)
	-- 4002
	self:AddAttrPercent(BufferEffect[4002], self.caster, target or self.owner, nil,"attack",0.1)
	-- 4302
	self:AddAttr(BufferEffect[4302], self.caster, target or self.owner, nil,"crit_rate",0.1)
end
