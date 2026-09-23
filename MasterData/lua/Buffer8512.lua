-- 被汲取防禦
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer8512 = oo.class(BuffBase)
function Buffer8512:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer8512:OnCreate(caster, target)
	-- 8408
	local fy1 = SkillApi:GetValue(self, self.caster, target or self.owner,4,"fy1")
	-- 8512
	self:AddAttr(BufferEffect[8512], self.caster, target or self.owner, nil,"defense",-fy1*0.2)
end
