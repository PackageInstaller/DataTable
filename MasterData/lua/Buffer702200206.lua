-- 相轉移
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer702200206 = oo.class(BuffBase)
function Buffer702200206:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer702200206:OnRoundBegin(caster, target)
	-- 6108
	self:ImmuneDamage(BufferEffect[6108], self.caster, target or self.owner, nil,nil)
end
-- 创建时
function Buffer702200206:OnCreate(caster, target)
	-- 6108
	self:ImmuneDamage(BufferEffect[6108], self.caster, target or self.owner, nil,nil)
end
