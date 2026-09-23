-- 狂暴狀態
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4906114 = oo.class(BuffBase)
function Buffer4906114:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4906114:OnCreate(caster, target)
	-- 4008
	self:AddAttrPercent(BufferEffect[4008], self.caster, target or self.owner, nil,"attack",0.4)
	-- 4108
	self:AddAttrPercent(BufferEffect[4108], self.caster, target or self.owner, nil,"defense",0.4)
end
