-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4103406 = oo.class(BuffBase)
function Buffer4103406:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4103406:OnCreate(caster, target)
	-- 8771
	local c771 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"crit")
	-- 4103416
	self:AddAttr(BufferEffect[4103416], self.caster, self.card, nil, "damage",(c771-1)*0.1)
end
