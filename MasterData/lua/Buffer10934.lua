-- 忘我攻勢-等級5
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10934 = oo.class(BuffBase)
function Buffer10934:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10934:OnCreate(caster, target)
	-- 4934
	self:AddAttrPercent(BufferEffect[4934], self.caster, target or self.owner, nil,"defense",-0.25)
	-- 4005
	self:AddAttrPercent(BufferEffect[4005], self.caster, target or self.owner, nil,"attack",0.25)
end
