-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer300600101 = oo.class(BuffBase)
function Buffer300600101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer300600101:OnCreate(caster, target)
	-- 8720
	local c116 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"hp")
	-- 300600101
	self:AddShieldValue(BufferEffect[300600101], self.caster, self.card, nil, math.floor(c116*0.1))
end
