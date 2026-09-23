-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4603102 = oo.class(BuffBase)
function Buffer4603102:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4603102:OnCreate(caster, target)
	-- 8767
	local c767 = SkillApi:GetAttr(self, self.caster, target or self.owner,4,"speed")
	-- 4603102
	self:AddAttr(BufferEffect[4603102], self.caster, self.card, nil, "attack",c767*0.4)
end
