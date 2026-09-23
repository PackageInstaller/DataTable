-- 忘我攻勢-等級2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10931 = oo.class(BuffBase)
function Buffer10931:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10931:OnCreate(caster, target)
	-- 4931
	self:AddAttrPercent(BufferEffect[4931], self.caster, target or self.owner, nil,"defense",-0.1)
	-- 4002
	self:AddAttrPercent(BufferEffect[4002], self.caster, target or self.owner, nil,"attack",0.1)
end
