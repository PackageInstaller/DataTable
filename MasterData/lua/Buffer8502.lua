-- 汲取防禦
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer8502 = oo.class(BuffBase)
function Buffer8502:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer8502:OnCreate(caster, target)
	-- 8408
	local fy1 = SkillApi:GetValue(self, self.caster, target or self.owner,4,"fy1")
	-- 8502
	self:AddAttr(BufferEffect[8502], self.caster, self.caster, nil, "defense",fy1*0.2)
end
