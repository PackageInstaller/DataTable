-- 高速形態
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4922901 = oo.class(BuffBase)
function Buffer4922901:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer4922901:OnRoundBegin(caster, target)
	-- 6109
	self:ImmuneDeath(BufferEffect[6109], self.caster, target or self.owner, nil,nil)
end
-- 创建时
function Buffer4922901:OnCreate(caster, target)
	-- 4208
	self:AddAttr(BufferEffect[4208], self.caster, target or self.owner, nil,"speed",40)
	-- 5004
	self:AddAttrPercent(BufferEffect[5004], self.caster, target or self.owner, nil,"attack",-0.2)
end
